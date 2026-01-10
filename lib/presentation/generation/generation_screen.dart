import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:ai_vid_gen/core/providers/generation_provider.dart';
import 'package:ai_vid_gen/core/theme/theme.dart';

class GenerationScreen extends ConsumerWidget {
  const GenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(isLoadingProvider);
    final result = ref.watch(resultProvider);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.background), // Black background
        child: SafeArea(
          child: isLoading ? _buildLoadingView() : _buildMainView(context, ref),
        ),
      ),
    );
  }

  Widget _buildMainView(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back button
            IconButton(
              onPressed: () {
                // Navigate back to home screen using go_router
                context.go('/home');
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),

            SizedBox(height: 16.h),

            // Title
            ShaderMask(
              shaderCallback: (bounds) {
                return AppColors.vibrantGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                );
              },
              child: Text(
                'Create Video',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 8.h),

            ShaderMask(
              shaderCallback: (bounds) {
                return AppColors.vibrantGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                );
              },
              child: Text(
                'Upload an image to generate video with AI',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ),

            SizedBox(height: 48.h),

            // Image upload area
            _ImageUploadArea(ref: ref),

            SizedBox(height: 48.h),

            // Generate button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _onGeneratePressed(context, ref);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.neonPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.w,
                    vertical: 18.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Generate',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie animasyonu
          LottieBuilder.asset(
            'assets/lottie/loading_animation.json', // Placeholder for loading animation
            width: 200.w,
            height: 200.h,
            errorBuilder: (context, error, stackTrace) {
              // Fallback widget when Lottie fails to load
              return Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: AppColors.neonPurple.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.neonPurple,
                    width: 2.w,
                  ),
                ),
                child: const Icon(
                  Icons.hourglass_empty,
                  color: Colors.white,
                  size: 100,
                ),
              );
            },
          ),

          SizedBox(height: 32.h),

          ShaderMask(
            shaderCallback: (bounds) {
              return AppColors.vibrantGradient.createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              );
            },
            child: Text(
              'Creating AI Video...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          Text(
            'This process may take a few minutes',
            style: TextStyle(color: Colors.white70, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  void _onGeneratePressed(BuildContext context, WidgetRef ref) async {
    // Loading state'i başlat
    ref.read(isLoadingProvider.notifier).state = true;

    // Simülasyon için 3 saniye beklet
    await Future.delayed(const Duration(seconds: 3));

    // Finish loading state and show mock result
    ref.read(isLoadingProvider.notifier).state = false;
    ref.read(resultProvider.notifier).state = 'Mock Video Result';

    // Navigate to result screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResultScreen()),
    );
  }
}

class _ImageUploadArea extends ConsumerWidget {
  final WidgetRef ref;

  const _ImageUploadArea({required this.ref});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 250.h,
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.neonPurple, width: 2.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.upload_outlined, color: AppColors.neonPurple, size: 60.sp),
          SizedBox(height: 16.h),
          Text(
            'Upload Image',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.neonPurple),
          ),
          SizedBox(height: 8.h),
          Text(
            'or drag and drop',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.neonPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.neonPurple, width: 1.w),
            ),
            child: Text(
              'Select File',
              style: TextStyle(
                color: AppColors.neonPurple,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.background), // Black background
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  IconButton(
                    onPressed: () {
                      // Navigate back to home screen using go_router
                      context.go('/home');
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Title
                  ShaderMask(
                    shaderCallback: (bounds) {
                      return AppColors.vibrantGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      );
                    },
                    child: Text(
                      'Video Created!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 48.h),

                  // Result image
                  Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.electricBlue,
                        width: 2.w,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.movie_filter_outlined,
                          color: AppColors.electricBlue,
                          size: 80.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Video Generated by AI',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.electricBlue,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Video information
                  _VideoInfoCard(),

                  SizedBox(height: 32.h),

                  // Share button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Share function
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricBlue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 18.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Share Video',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}

class _VideoInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.neonPurple, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Video Details',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          _InfoRow(label: 'Quality:', value: '4K'),
          SizedBox(height: 8.h),
          _InfoRow(label: 'Format:', value: 'MP4'),
          SizedBox(height: 8.h),
          _InfoRow(label: 'Duration:', value: '30 seconds'),
          SizedBox(height: 8.h),
          _InfoRow(label: 'Size:', value: '15 MB'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
