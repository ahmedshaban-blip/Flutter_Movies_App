import 'package:flutter/material.dart';

class AppColors {
  // Brand & accents
  static const Color brandPrimary = Color(0xFFe94560);

  // Dark backgrounds used in the screen
  static const Color bgDarkTop = Color(0xFF1a1a2e);
  static const Color bgDark = Color(0xFF0f0f1e);
  static const Color bgDarkBottom = Color(0xFF0a0a14);

  // Card gradient (tile)
  static const Color cardGradStart = Color(0xFF1f1f3a);
  static const Color cardGradEnd = Color(0xFF16213e);

  // Ratings
  static const Color ratingHigh = Color(0xFF00e676);
  static const Color ratingMid = Color(0xFFffd600);
  static const Color ratingLow = Color(0xFFff6b6b);
}

@immutable
class AppGradients extends ThemeExtension<AppGradients> {
  final List<Color> bgGradient; // خلفية الشاشة
  final List<Color> cardGradient; // تدرج البطاقة

  const AppGradients({
    required this.bgGradient,
    required this.cardGradient,
  });

  @override
  AppGradients copyWith({List<Color>? bgGradient, List<Color>? cardGradient}) {
    return AppGradients(
      bgGradient: bgGradient ?? this.bgGradient,
      cardGradient: cardGradient ?? this.cardGradient,
    );
  }

  @override
  AppGradients lerp(ThemeExtension<AppGradients>? other, double t) {
    if (other is! AppGradients) return this;
    return AppGradients(
      bgGradient: List<Color>.generate(
        bgGradient.length,
        (i) => Color.lerp(bgGradient[i], other.bgGradient[i], t)!,
      ),
      cardGradient: List<Color>.generate(
        cardGradient.length,
        (i) => Color.lerp(cardGradient[i], other.cardGradient[i], t)!,
      ),
    );
  }

  static AppGradients light(ColorScheme s) => AppGradients(
        bgGradient: [s.surface, s.background, s.surfaceVariant],
        cardGradient: [s.surface, s.primaryContainer.withOpacity(0.5)],
      );

  static AppGradients dark(ColorScheme s) => const AppGradients(
        bgGradient: [
          AppColors.bgDarkTop,
          AppColors.bgDark,
          AppColors.bgDarkBottom
        ],
        cardGradient: [AppColors.cardGradStart, AppColors.cardGradEnd],
      );
}

// core/theme/app_semantic_colors.dart

@immutable
class AppSemanticColors extends ThemeExtension<AppSemanticColors> {
  final Color ratingHigh;
  final Color ratingMid;
  final Color ratingLow;

  const AppSemanticColors({
    required this.ratingHigh,
    required this.ratingMid,
    required this.ratingLow,
  });

  @override
  AppSemanticColors copyWith(
      {Color? ratingHigh, Color? ratingMid, Color? ratingLow}) {
    return AppSemanticColors(
      ratingHigh: ratingHigh ?? this.ratingHigh,
      ratingMid: ratingMid ?? this.ratingMid,
      ratingLow: ratingLow ?? this.ratingLow,
    );
  }

  @override
  AppSemanticColors lerp(ThemeExtension<AppSemanticColors>? other, double t) {
    if (other is! AppSemanticColors) return this;
    return AppSemanticColors(
      ratingHigh: Color.lerp(ratingHigh, other.ratingHigh, t)!,
      ratingMid: Color.lerp(ratingMid, other.ratingMid, t)!,
      ratingLow: Color.lerp(ratingLow, other.ratingLow, t)!,
    );
  }

  static const AppSemanticColors common = AppSemanticColors(
    ratingHigh: AppColors.ratingHigh,
    ratingMid: AppColors.ratingMid,
    ratingLow: AppColors.ratingLow,
  );
}
