import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_info.dart';

class ArticleInfoWidget extends StatelessWidget {
  final ArticleInfo articleInfo;

  const ArticleInfoWidget({
    super.key,
    required this.articleInfo,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Article Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              if (articleInfo.ean != null)
                _InfoRow(label: 'EAN', value: articleInfo.ean!),
              if (articleInfo.articleNumber != null)
                _InfoRow(label: 'Article Number', value: articleInfo.articleNumber!),
              if (articleInfo.plu != null)
                _InfoRow(label: 'PLU', value: articleInfo.plu!),
              if (articleInfo.description != null)
                _InfoRow(label: 'Description', value: articleInfo.description!),
              if (articleInfo.price != null)
                _InfoRow(label: 'Price', value: articleInfo.price!),
              if (articleInfo.stock != null)
                _InfoRow(label: 'Stock', value: articleInfo.stock!),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
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
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

