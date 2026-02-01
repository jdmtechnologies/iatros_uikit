import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iatros_ui/iatros_ui_kit.dart';
import 'package:iatros_ui/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserSearchInput extends ConsumerStatefulWidget {
  final String hint;
  final String label;
  final int maxResults;
  final bool showResults;
  final Duration debounceTime;
  final Function(String)? onSearchChanged;
  final Function(List<UserModel>)? onUsersFound;
  final Future<List<UserModel>> Function(String) getUsers;

  const UserSearchInput({
    super.key,
    this.onUsersFound,
    this.onSearchChanged,
    this.maxResults = 10,
    required this.getUsers,
    this.showResults = true,
    this.label = 'Buscar Usuario',
    this.hint = 'Buscar por documento...',
    this.debounceTime = const Duration(milliseconds: 500),
  });

  @override
  ConsumerState<UserSearchInput> createState() => _UserSearchInputState();
}

class _UserSearchInputState extends ConsumerState<UserSearchInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<UserModel> _searchResults = [];
  bool _isSearching = false;
  bool _showResults = false;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _controller.text.trim();
    
    // Cancelar timer anterior
    _debounceTimer?.cancel();
    
    // Llamar callback inmediatamente
    widget.onSearchChanged?.call(query);
    
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _showResults = false;
      });
      return;
    }

    // Buscar después del debounce
    _debounceTimer = Timer(widget.debounceTime, () {
      _performSearch(query);
    });
  }

  void _onFocusChanged() {
    setState(() {
      _showResults = _focusNode.hasFocus && _searchResults.isNotEmpty;
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await widget.getUsers(query);
      
      setState(() {
        _searchResults = results.take(widget.maxResults).toList();
        _isSearching = false;
        _showResults = _focusNode.hasFocus && _searchResults.isNotEmpty;
      });

      widget.onUsersFound?.call(_searchResults);
    } catch (e) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
        _showResults = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al buscar usuarios: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _selectUser(UserModel user) {
    _controller.text = user.medicalLicense;
    setState(() {
      _showResults = false;
    });
    _focusNode.unfocus();
  }

  void _clearSearch() {
    _controller.clear();
    setState(() {
      _searchResults = [];
      _showResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input field
        UiTextInput(
          controller: _controller,
          label: widget.label,
          hint: widget.hint,
          suffixIcon: _isSearching
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : _controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                      iconSize: 20,
                    )
                  : const Icon(Icons.search),
        ),
        
        // Search results
        if (widget.showResults && _showResults) ...[
          UIHelpers.verticalSpaceSM,
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
              border: Border.all(color: AppColors.textSecondary.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _searchResults.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(AppSpacing.paddingMD),
                    child: Text(
                      _isSearching ? 'Buscando...' : 'No se encontraron usuarios',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final user = _searchResults[index];
                      return _UserSearchResultItem(
                        user: user,
                        onTap: () => _selectUser(user),
                      );
                    },
                  ),
          ),
        ],
      ],
    );
  }
}

class _UserSearchResultItem extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const _UserSearchResultItem({
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingMD),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: AppTypography.h6.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
            UIHelpers.horizontalSpaceMD,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (user.medicalLicense.isNotEmpty) ...[
                    UIHelpers.verticalSpaceXS,
                    Text(
                      'Documento: ${user.medicalLicense}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  if (user.specialization.isNotEmpty) ...[
                    UIHelpers.verticalSpaceXS,
                    Text(
                      user.specialization,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
