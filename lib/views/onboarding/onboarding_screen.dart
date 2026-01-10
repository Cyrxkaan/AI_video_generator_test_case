import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_vid_gen/core/services/onboarding_service.dart';
import 'package:ai_vid_gen/core/theme/theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Create Amazing Videos',
      description: 'Use AI to generate stunning videos in seconds',
      icon: Icons.auto_awesome,
    ),
    OnboardingPage(
      title: 'Customize Your Content',
      description: 'Personalize every detail of your video',
      icon: Icons.edit,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.background, // Black background
        ),
        child: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _pages[index];
                },
              ),
              // Skip Button
              Positioned(
                top: 20.h,
                right: 24.w,
                child: TextButton(
                  onPressed: () async {
                    // Skip to paywall
                    await OnboardingService.setOnboardingCompleted();
                    context.push('/paywall');
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Dots Indicator
              Positioned(
                bottom: 120.h, // Moved higher to be above buttons
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: _currentPage == index ? 24.w : 8.w,
                      height: 8.h,
                      decoration: _currentPage == index
                            ? BoxDecoration(
                                color: AppColors.electricBlue,
                                borderRadius: BorderRadius.circular(4.r),
                              )
                            : BoxDecoration(
                                color: Colors.white30,
                                shape: BoxShape.circle,
                              ),
                    ),
                  ),
                ),
              ),
              // Next/Get Started Button
              Positioned(
                bottom: 40.h,
                left: 24.w,
                right: 24.w,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _currentPage == _pages.length - 1
                      ? Container(
                          height: 65,
                          decoration: BoxDecoration(
                            gradient: AppColors.vibrantGradient,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ElevatedButton(
                            key: const ValueKey('getStarted'),
                            onPressed: () async {
                              await OnboardingService.setOnboardingCompleted();
                              context.push('/paywall');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          height: 65,
                          decoration: BoxDecoration(
                            gradient: AppColors.vibrantGradient,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ElevatedButton(
                            key: const ValueKey('next'),
                            onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 16.h,  // Reduced padding to move content higher
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: AppColors.electricBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColors.electricBlue,
                width: 2.w,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: AppColors.electricBlue,
                size: 60.sp,
              ),
            ),
          ),
          SizedBox(height: 48.h),
          ShaderMask(
            shaderCallback: (bounds) {
              return AppColors.vibrantGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              );
            },
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          ShaderMask(
            shaderCallback: (bounds) {
              return AppColors.vibrantGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              );
            },
            child: Text(
              description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}