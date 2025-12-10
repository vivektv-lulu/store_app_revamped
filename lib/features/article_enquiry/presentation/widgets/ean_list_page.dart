import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/article_info.dart';

class EanListPage extends StatelessWidget {
  final ArticleInfo articleInfo;

  const EanListPage({super.key, required this.articleInfo});

  // Mock EAN list with conversions - in real app, this would come from API
  List<Map<String, String>> _getEanList() {
    // If EAN exists in articleInfo, use it; otherwise use mock data
    final eanList = <Map<String, String>>[];

    if (articleInfo.ean != null) {
      eanList.add({
        'ean': articleInfo.ean!,
        'conversion':
            '${articleInfo.uom ?? "EA"} = 1 ${articleInfo.uom ?? "EA"}',
      });
    }

    // Add additional mock EANs for demonstration
    eanList.addAll([
      {'ean': '230000000012203', 'conversion': 'EA = 1 EA'},
      {'ean': '230000000012210', 'conversion': 'EA = 1 EA'},
      {'ean': '230000000012227', 'conversion': 'PK = 12 EA'},
    ]);

    return eanList;
  }

  @override
  Widget build(BuildContext context) {
    final eanList = _getEanList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section - matching page 1
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.appBarBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (articleInfo.itemName != null)
                  Text(
                    articleInfo.itemName!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                if (articleInfo.articleNumber != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Article Number: ${articleInfo.articleNumber!}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
                if (articleInfo.amount != null) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      articleInfo.amount!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 12),

          // EAN List section
          Text(
            'EAN List with Conversions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // EAN List table
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withOpacity(0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Table header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'EAN',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 16,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Conversion',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Table rows
                ..._buildTableRows(eanList),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTableRows(List<Map<String, String>> eanList) {
    final rows = <Widget>[];

    for (int i = 0; i < eanList.length; i++) {
      final eanData = eanList[i];
      final isLast = i == eanList.length - 1;

      rows.add(
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: isLast
                  ? BorderSide.none
                  : BorderSide(
                      color: AppColors.primary.withOpacity(0.1),
                      width: 1,
                    ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    eanData['ean']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 16,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  color: AppColors.primary.withOpacity(0.1),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    eanData['conversion']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return rows;
  }
}
