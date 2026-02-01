import 'package:flutter/material.dart';
import 'package:iatros_uikit/iatros_ui_kit.dart';
import 'package:image_picker_loading_jm/image_picker_loading_jm.dart';

class ImageButton extends StatelessWidget {
  final double size;
  final String? image;
  final IconData? icon;
  final Function() onTap;

  const ImageButton({
    super.key,
    this.icon,
    this.image = "",
    this.size = 100,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      child: Container(
        width: 150,
        height: 150,
        padding: EdgeInsets.all(size < 40 ? 2 : 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary.withOpacity(0.4),
            width: 2,
          ),
        ),
        child: Material(
          color: AppColors.primary.withOpacity(0.15),
          shape: CircleBorder(),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onTap,
            child: image!.isEmpty
                ? Center(
                    child: Icon(
                      icon ?? Icons.person,
                      size: size / 2,
                      color: AppColors.primary,
                    ),
                  )
                : ImagePickerLoadingJM(
                    imagePickerLoadingJModel: ImagePickerLoadingJModel(
                      image: image!,
                      imageError: "assets/image/error.jpg",
                      buildBody: (_, provider) => Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: provider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
