import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';

class ModuleDetailPage extends StatelessWidget {
  const ModuleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    final moduleId = arguments?['id'] ?? 'Unknown';
    final moduleTitle = arguments?['title'] ?? 'Module Detail';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarBg,
        foregroundColor: AppColors.textPrimary,
        title: Text(moduleTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: AppColors.surface,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inventory_2,
                  size: 80,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  moduleTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Module ID: $moduleId',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'This is a placeholder screen for the module.\n'
                  'Implement the specific functionality here.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

