import 'package:flutter/material.dart';
import 'package:movie_app/features/details/presentation/pages/details_page.dart';
import 'package:movie_app/features/home/data/models/home_model.dart';
import 'package:movie_app/features/home/presentation/pages/home_page.dart';
import '../routing/routes.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _createRoute(const SplashScreen());
      case Routes.onBoardingScreen:
        return _createRoute(const OnboardingScreen());
      case Routes.homeScreen:
        return _createRoute(const HomePage());
      case Routes.detailsScreen:
        final movie = settings.arguments as Movie;
        print(movie);
        return _createRoute(DetailsPage(
          movie: movie,
        ));

      default:
        return null;
    }
  }

  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}
