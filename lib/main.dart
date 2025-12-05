import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/app_colors.dart';
import 'features/home_screen/presentation/pages/home_page.dart';
import 'features/home_screen/presentation/pages/module_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Store App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          primaryContainer: AppColors.primary700,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
          onPrimary: AppColors.onPrimary,
          onSecondary: AppColors.onSecondary,
          onSurface: AppColors.onSurface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appBarBg,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        scaffoldBackgroundColor: AppColors.inputFill,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/module-detail',
          page: () => const ModuleDetailPage(),
        ),
      ],
    );
  }
}

