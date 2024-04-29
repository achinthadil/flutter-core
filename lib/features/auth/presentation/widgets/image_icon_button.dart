import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/themes/app_pallete.dart';

class ImageIconButton extends StatelessWidget {
  const ImageIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPallete.greenColor, AppPallete.greenColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppPallete.greenColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: const Size(55, 55),
          backgroundColor: AppPallete.whiteColor,
          foregroundColor: AppPallete.whiteColor,
        ),
        onPressed: onPressed,
        child: SvgPicture.asset(
          height: 40,
          width: 40,
          icon,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
