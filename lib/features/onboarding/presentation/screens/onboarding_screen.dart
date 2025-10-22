import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1a1a2e),
              const Color(0xFF16213e),
              const Color(0xFF0f3460),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) =>
                      setState(() => isLastPage = index == 2),
                  children: const [
                    OnboardPage(
                      title: 'Stay in the Spotlight',
                      description:
                          'Browse today’s hottest hits, top-rated classics, and brand-new releases all in one place. Swipe through curated carousels like “Just Added,” “Most Popular,” and “Critics’ Picks',
                    ),
                    OnboardPage(
                      title: 'Your Movie Library',
                      description:
                          'Tap the “+” to save any title for later—no more forgetting that indie gem you spotted! Organize your list by genre, mood, or release date so you’re always ready for movie night.',
                    ),
                    OnboardPage(
                        title: 'Because You Loved',
                        description:
                            'Our smart engine learns your tastes to suggest movies you’ll actually enjoy. Rate films you’ve watched and get personalized picks every time you open the app.'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (isLastPage) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/homeScreen', (route) => false);
                    } else {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(isLastPage ? 'Get Started' : 'Next'),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String title;
  final String description;
  const OnboardPage(
      {super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.movie_creation_outlined, color: Colors.white, size: 120.r),
          SizedBox(height: 20.h),
          Text(
            title,
            style: GoogleFonts.nunito(
              textStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                textStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
