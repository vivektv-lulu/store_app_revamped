import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/home_item.dart';
import 'module_background.dart';

class ModuleCardWidget extends StatelessWidget {
  final HomeItem item;
  final VoidCallback onTap;

  const ModuleCardWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: ModuleBackground(
            moduleId: item.id,
              child: Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.surface.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      _getIconForModule(item.id),
                      color: AppColors.secondary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getIconForModule(String id) {
    switch (id) {
      case '1':
        return Icons.search;
      case '2':
        return Icons.store;
      case '3':
        return Icons.print;
      case '4':
        return Icons.local_shipping;
      case '5':
        return Icons.inventory;
      case '6':
        return Icons.swap_horiz;
      case '7':
        return Icons.bookmark;
      case '8':
        return Icons.restaurant;
      case '9':
        return Icons.undo;
      case '10':
        return Icons.inventory_2;
      default:
        return Icons.apps;
    }
  }
}

