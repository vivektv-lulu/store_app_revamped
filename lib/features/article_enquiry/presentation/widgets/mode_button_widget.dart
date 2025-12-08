import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_enquiry_mode.dart';

class ModeButtonWidget extends StatelessWidget {
  final ArticleEnquiryMode mode;
  final bool isSelected;
  final VoidCallback onTap;

  const ModeButtonWidget({
    super.key,
    required this.mode,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondary : AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? AppColors.secondary
                : AppColors.secondary.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            mode.shortForm,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.onSecondary
                  : AppColors.secondary,
            ),
          ),
        ),
      ),
    );
  }
}

