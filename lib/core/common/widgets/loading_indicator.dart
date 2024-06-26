import 'package:flutter/material.dart';
import 'package:marvel_comics_app/core/res/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.2,
      child: const CircularProgressIndicator(
        color: AppColors.loadingIndicatorColor,
        strokeWidth: 6,
      ),
    );
  }
}
