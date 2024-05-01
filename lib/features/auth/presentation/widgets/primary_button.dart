import 'package:flutter/material.dart';

import '../../../../core/themes/app_pallete.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.title,
    required this.onPressed,
    super.key,
  });

  final String title;
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
        borderRadius: BorderRadius.circular(7),
        // boxShadow: const [
        //   BoxShadow(
        //     color: AppPallete.greenColor,
        //     spreadRadius: 1,
        //     blurRadius: 15,
        //     offset: Offset(0, 0),
        //   )
        // ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
          fixedSize: Size(MediaQuery.of(context).size.width, 55),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppPallete.whiteColor,
          ),
        ),
      ),
    );
  }
}
