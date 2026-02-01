import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';
import 'package:iatros_uikit/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iatros_uikit/components/cards/base_card.dart';
import 'package:iatros_uikit/components/buttons/primary_button.dart';
import 'package:iatros_uikit/components/inputs/user_search_input.dart';

/// Ejemplo de uso del UserSearchInput
class UserSearchExample extends ConsumerStatefulWidget {
  final Future<List<UserModel>> Function(String) getUsers;
  const UserSearchExample({super.key, required this.getUsers});

  @override
  ConsumerState<UserSearchExample> createState() => _UserSearchExampleState();
}

class _UserSearchExampleState extends ConsumerState<UserSearchExample> {
  List<UserModel> _selectedUsers = [];
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Búsqueda de Usuarios'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.paddingLG),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Buscar Usuarios',
              style: AppTypography.h4,
            ),
            UIHelpers.verticalSpaceMD,
            UserSearchInput(
              getUsers: widget.getUsers,
              label: 'Buscar por Documento',
              hint: 'Ingresa el número de documento...',
              onUsersFound: (users) {
                setState(() {
                  _selectedUsers = users;
                });
              },
              onSearchChanged: (query) {
                setState(() {
                  _searchQuery = query;
                });
              },
              maxResults: 5,
              debounceTime: const Duration(milliseconds: 300),
            ),

            UIHelpers.verticalSpaceLG,

            // Información de búsqueda
            if (_searchQuery.isNotEmpty) ...[
              Text(
                'Buscando: "$_searchQuery"',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              UIHelpers.verticalSpaceSM,
            ],

            // Resultados
            if (_selectedUsers.isNotEmpty) ...[
              Text(
                'Resultados encontrados: ${_selectedUsers.length}',
                style: AppTypography.h6,
              ),
              UIHelpers.verticalSpaceMD,
              Expanded(
                child: ListView.builder(
                  itemCount: _selectedUsers.length,
                  itemBuilder: (context, index) {
                    final user = _selectedUsers[index];
                    return BaseCard(
                      margin: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          child: Text(
                            user.name.isNotEmpty
                                ? user.name[0].toUpperCase()
                                : 'U',
                            style: AppTypography.h6.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (user.medicalLicense.isNotEmpty)
                              Text('Documento: ${user.medicalLicense}'),
                            if (user.specialization.isNotEmpty)
                              Text(
                                user.specialization,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            if (user.email.isNotEmpty)
                              Text(
                                user.email,
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                          ],
                        ),
                        trailing: PrimaryButton(
                          label: 'Seleccionar',
                          onPressed: () {
                            _showUserDetails(user);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else if (_searchQuery.isNotEmpty) ...[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      UIHelpers.verticalSpaceMD,
                      Text(
                        'No se encontraron usuarios',
                        style: AppTypography.h6.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      UIHelpers.verticalSpaceSM,
                      Text(
                        'Intenta con otro término de búsqueda',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      UIHelpers.verticalSpaceMD,
                      Text(
                        'Busca usuarios por documento',
                        style: AppTypography.h6.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      UIHelpers.verticalSpaceSM,
                      Text(
                        'Ingresa el número de documento en el campo de búsqueda',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showUserDetails(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detalles del Usuario'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DetailRow('Nombre', user.name),
            _DetailRow('Email', user.email),
            _DetailRow('Teléfono', user.phone),
            _DetailRow(
                'Documento',
                user.medicalLicense.isNotEmpty
                    ? user.medicalLicense
                    : 'No especificado'),
            _DetailRow('Especialización', user.specialization),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
          PrimaryButton(
            label: 'Seleccionar',
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Usuario ${user.name} seleccionado'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: AppTypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
