import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_vid_gen/core/theme/theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Use go to navigate to home screen instead of pushNamed
            context.go('/home');
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.background), // Black background
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.electricBlue,
                          width: 2.w,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundColor: AppColors.background,
                        child: Icon(
                          Icons.person,
                          color: AppColors.electricBlue,
                          size: 30.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return AppColors.vibrantGradient.createShader(
                                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                              );
                            },
                            child: Text(
                              'John Doe',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Text(
                            'Premium Member',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColors.electricBlue,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),

                // Profile Options
                _ProfileOptionCard(
                  icon: Icons.history,
                  title: 'My Creations',
                  subtitle: 'View your generated videos',
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _ProfileOptionCard(
                  icon: Icons.settings,
                  title: 'Settings',
                  subtitle: 'App preferences and configuration',
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _ProfileOptionCard(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  subtitle: 'Get help with the app',
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                _ProfileOptionCard(
                  icon: Icons.logout,
                  title: 'Logout',
                  subtitle: 'Sign out of your account',
                  onTap: () {},
                ),
                
                const Spacer(),
                
                // Logout Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.red,
                    side: BorderSide(color: Colors.red, width: 1.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        'Logout',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
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

class _ProfileOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ProfileOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.secondaryGradient,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.electricBlue.withOpacity(0.5),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Card(
      child: ListTile(
        leading: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.electricBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            icon,
            color: AppColors.electricBlue,
            size: 20.sp,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white70,
          size: 16.sp,
        ),
        onTap: onTap,
      ),
    ),
  );
  }
}