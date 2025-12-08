import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_info.dart';

class ArticleDetailsPage extends StatelessWidget {
  final ArticleInfo articleInfo;

  const ArticleDetailsPage({
    super.key,
    required this.articleInfo,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header section - compact
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.appBarBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Item Name (no label)
                if (articleInfo.itemName != null)
                  Expanded(
                    child: Text(
                      articleInfo.itemName!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                
                // Amount (no label)
                if (articleInfo.amount != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      articleInfo.amount!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Article Number below header
          if (articleInfo.articleNumber != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                articleInfo.articleNumber!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
            ),
          
          // Body section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fields with labels
                if (articleInfo.mrp != null)
                  _LabeledField(label: 'MRP', value: articleInfo.mrp!),
                if (articleInfo.brand != null)
                  _LabeledField(label: 'Brand', value: articleInfo.brand!),
                if (articleInfo.mc != null)
                  _LabeledField(label: 'MC', value: articleInfo.mc!),
                if (articleInfo.mcText != null)
                  _LabeledField(label: 'MC Text', value: articleInfo.mcText!),
                if (articleInfo.stock != null)
                  _LabeledField(label: 'Stock', value: articleInfo.stock!),
                if (articleInfo.uom != null)
                  _LabeledField(label: 'UoM', value: articleInfo.uom!),
                if (articleInfo.shelfNo != null)
                  _LabeledField(label: 'Shelf No.', value: articleInfo.shelfNo!),
                if (articleInfo.vendor != null)
                  _LabeledField(label: 'Vendor', value: articleInfo.vendor!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final String value;

  const _LabeledField({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

