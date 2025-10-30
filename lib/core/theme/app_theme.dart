import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
      textTheme: const TextTheme().apply(
        bodyColor: scheme.onBackground,
        displayColor: scheme.onBackground,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppSemanticColors.common,
        AppGradients.light(scheme),
      ],
    );
  }

  static ThemeData get darkTheme {
    final base = ColorScheme.fromSeed(
      seedColor: AppColors.brandPrimary,
      brightness: Brightness.dark,
    );
    final scheme = base.copyWith(
      background: AppColors.bgDark,
      surface: AppColors.cardGradStart,
      surfaceVariant: AppColors.cardGradEnd,
      primary: AppColors.brandPrimary,
      onBackground: Colors.white,
      onSurface: Colors.white,
      onPrimary: Colors.white,
      // اجعل error كما تريد
      error: const Color(0xFFEF5350),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
      textTheme: const TextTheme().apply(
        bodyColor: scheme.onBackground,
        displayColor: scheme.onBackground,
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppSemanticColors.common,
        AppGradients.dark(scheme),
      ],
    );
  }
}
