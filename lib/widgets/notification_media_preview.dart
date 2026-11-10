import 'package:flutter/material.dart';
import 'package:iatros_uikit/enum/notification_enums.dart';
import 'package:iatros_uikit/models/notification_model.dart';
import 'package:iatros_uikit/utils/spacing.dart';
import 'package:iatros_uikit/utils/text_style.dart';
import 'package:iatros_uikit/utils/ui_color.dart';

/// Adjunto de una notificación, al estilo de WhatsApp:
/// - imagen → la imagen dentro de la notificación;
/// - video → la miniatura con un botón de play encima;
/// - documento → un botón con el nombre del archivo.
///
/// Al tocarlo llama a [onOpen] (quien lo usa abre la URL). No muestra nada si
/// la notificación no tiene URL.
class NotificationMediaPreview extends StatelessWidget {
  const NotificationMediaPreview({
    super.key,
    required this.notification,
    required this.onOpen,
    this.maxHeight = 220,
  });

  final NotificationModel notification;
  final VoidCallback onOpen;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return switch (notification.mediaType) {
      null => const SizedBox.shrink(),
      NotificationMediaType.image => _ImagePreview(
        notification: notification,
        onOpen: onOpen,
        maxHeight: maxHeight,
      ),
      NotificationMediaType.video => _VideoPreview(
        notification: notification,
        onOpen: onOpen,
        maxHeight: maxHeight,
      ),
      NotificationMediaType.document => _DocumentButton(
        notification: notification,
        onOpen: onOpen,
      ),
    };
  }
}

/// Imagen de red que en web no depende de CORS (usa un `<img>` si hace falta).
Widget _networkImage(String url, {required Widget Function() onError}) {
  return Image.network(
    url,
    fit: BoxFit.cover,
    width: double.infinity,
    height: double.infinity,
    webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
    loadingBuilder: (context, child, progress) => progress == null
        ? child
        : Container(
            color: AppColors.gray100,
            alignment: Alignment.center,
            child: const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
    errorBuilder: (context, error, stackTrace) => onError(),
  );
}

class _MediaFrame extends StatelessWidget {
  const _MediaFrame({
    required this.onOpen,
    required this.maxHeight,
    required this.aspectRatio,
    required this.child,
    required this.tooltip,
  });

  final VoidCallback onOpen;
  final double maxHeight;
  final double aspectRatio;
  final Widget child;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMD),
            child: Material(
              color: AppColors.gray100,
              child: InkWell(onTap: onOpen, child: child),
            ),
          ),
        ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  const _ImagePreview({
    required this.notification,
    required this.onOpen,
    required this.maxHeight,
  });

  final NotificationModel notification;
  final VoidCallback onOpen;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return _MediaFrame(
      onOpen: onOpen,
      maxHeight: maxHeight,
      aspectRatio: 4 / 3,
      tooltip: 'Ver imagen',
      child: _networkImage(
        notification.url!.trim(),
        onError: () => const Center(
          child: Icon(
            Icons.broken_image_outlined,
            color: AppColors.gray400,
            size: 36,
          ),
        ),
      ),
    );
  }
}

class _VideoPreview extends StatelessWidget {
  const _VideoPreview({
    required this.notification,
    required this.onOpen,
    required this.maxHeight,
  });

  final NotificationModel notification;
  final VoidCallback onOpen;
  final double maxHeight;

  /// Fondo cuando el video no tiene miniatura (Loom, Drive, .mp4...).
  Widget _placeholder() => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.gray800, AppColors.black],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final thumbnail = notification.thumbnailUrl;
    final host = notification.urlHost;

    return _MediaFrame(
      onOpen: onOpen,
      maxHeight: maxHeight,
      aspectRatio: 16 / 9,
      tooltip: 'Ver video',
      child: Stack(
        fit: StackFit.expand,
        children: [
          thumbnail == null
              ? _placeholder()
              : _networkImage(thumbnail, onError: _placeholder),
          // Oscurece un poco para que se lea el play sobre cualquier imagen.
          Container(color: AppColors.black.withValues(alpha: 0.18)),
          Center(
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.black.withValues(alpha: 0.55),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.85),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.white,
                size: 36,
              ),
            ),
          ),
          if (host != null)
            Positioned(
              left: 8,
              bottom: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusSM),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.videocam_outlined,
                      color: AppColors.white,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      host,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DocumentButton extends StatelessWidget {
  const _DocumentButton({required this.notification, required this.onOpen});

  final NotificationModel notification;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final name = notification.fileName ?? '';
    final isPdf = name.toLowerCase().endsWith('.pdf');

    return Tooltip(
      message: name.isEmpty ? notification.url! : name,
      child: OutlinedButton.icon(
        onPressed: onOpen,
        icon: Icon(
          isPdf ? Icons.picture_as_pdf_outlined : Icons.description_outlined,
          size: 18,
        ),
        label: Text(notification.effectiveUrlLabel),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.4)),
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
