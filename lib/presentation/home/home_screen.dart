import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_vid_gen/core/theme/theme.dart';
import 'package:ai_vid_gen/presentation/widgets/error_widget.dart' as custom_widgets;
import 'package:ai_vid_gen/presentation/providers/category_provider.dart';
import '../../domain/entities/category.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80.h,
        leading: null, 
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20.w),
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              gradient: AppColors.vibrantGradient,
              borderRadius: BorderRadius.circular(18.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonPurple.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return AppColors.secondaryGradient.createShader(
                  Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                );
              },
              child: IconButton(
                onPressed: () {
                  // Navigate to profile screen using go_router
                  context.go('/profile');
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                iconSize: 28.sp,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.background, // Black background
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                ShaderMask(
                  shaderCallback: (bounds) {
                    return AppColors.vibrantGradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    );
                  },
                  child: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w800, // Extra bold
                      fontFamily: 'Poppins', // Different font family if available
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Choose a category to create your video',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600, // Medium bold
                  ),
                ),
                SizedBox(height: 32.h),
                
                // Categories list
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 10.h),
                    padding: EdgeInsets.all(1.w),
                    decoration: BoxDecoration(
                      gradient: AppColors.vibrantGradient,
                      borderRadius: BorderRadius.circular(28.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.neonPurple.withOpacity(0.7),
                          spreadRadius: 4,
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(26.r),
                      ),
                      child: categoriesAsync.when(
                        data: (categories) {
                          if (categories.isEmpty) {
                            return const Center(
                              child: Text(
                                'No categories available',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return PageView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              return _CategoryCard(
                                category: category,
                                isCentered: true,
                              );
                            },
                          );
                        },
                        error: (error, stack) => custom_widgets.ErrorWidget(
                          message: 'Failed to load categories: \${error.toString()}',
                          onRetry: () {
                            ref.invalidate(categoriesProvider);
                          },
                        ),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}


class _CategoryCard extends ConsumerWidget {
  final Category category;
  final bool isCentered;

  const _CategoryCard({required this.category, this.isCentered = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: isCentered ? MediaQuery.of(context).size.width * 0.99 : null, // Even wider when centered
      height: 260.h, // Even shorter height
      margin: EdgeInsets.symmetric(horizontal: isCentered ? 10.w : 8.w), // Adjusted margin
      child: GestureDetector(
        onTap: () {
          // Navigate to the generation screen when a category is selected
          context.go('/generation');
        },
        child: Card(
          elevation: isCentered ? 8 : 4, // Higher elevation when centered
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isCentered ? 24.r : 16.r), // Larger radius when centered
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.secondaryGradient, // Neon gradient background
              borderRadius: BorderRadius.circular(isCentered ? 24.r : 16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonPurple.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              // Add slight blur effect to background
              color: Colors.black.withOpacity(0.2),
            ),
            child: Column(
              children: [
                // Make image take up most of the card
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.electricBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(isCentered ? 24.r : 16.r)),
                    ),
                    child: category.iconUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(isCentered ? 24.r : 16.r)),
                            child: Image.network(
                              category.iconUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                // Show fallback icon if image fails to load
                                return Icon(
                                  Icons.movie_creation_outlined,
                                  color: AppColors.electricBlue,
                                  size: 50.sp, // Larger icon
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.movie_creation_outlined,
                            color: AppColors.electricBlue,
                            size: 50.sp, // Larger icon
                          ),
                  ),
                ),
                // Text content at the bottom
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(1.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return AppColors.vibrantGradient.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                            );
                          },
                          child: Text(
                            category.name,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith( // Larger, more readable font
                              color: Colors.white,
                              fontWeight: FontWeight.w900, // Maximum bold text
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Text(
                            category.description,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith( // Larger, more readable font
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
