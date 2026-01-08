import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:ai_vid_gen/core/providers/subscription_provider.dart';
import 'package:ai_vid_gen/core/theme/theme.dart';

class PaywallScreen extends ConsumerWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSubscription = ref.watch(subscriptionTypeProvider);
    final plans = subscriptionPlans;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.vibrantGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Üst görsel alanı
                Container(
                  height: 250.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: LottieBuilder.asset(
                        'assets/lottie/video_generation.json', // Placeholder for video generation animation
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24.h),
                
                // Başlık
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    'Unlock Premium Features',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                
                SizedBox(height: 8.h),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    'Create unlimited videos with AI',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Özellik listesi
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeatureItem(
                        icon: Icons.auto_awesome,
                        text: 'Sınırsız AI Video',
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.high_quality,
                        text: '4K Kalite',
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.flash_on,
                        text: 'Hızlı İşleme',
                      ),
                      SizedBox(height: 16.h),
                      FeatureItem(
                        icon: Icons.support_agent,
                        text: 'Premium Destek',
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Abonelik kartları
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      // Abonelik türü değiştirici
                      Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(subscriptionTypeProvider.notifier)
                                      .state = SubscriptionType.monthly;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selectedSubscription == SubscriptionType.monthly
                                        ? AppColors.neonPurple
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(25.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Aylık',
                                    style: TextStyle(
                                      color: selectedSubscription == SubscriptionType.monthly
                                          ? Colors.white
                                          : Colors.white70,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  ref.read(subscriptionTypeProvider.notifier)
                                      .state = SubscriptionType.yearly;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selectedSubscription == SubscriptionType.yearly
                                        ? AppColors.neonPurple
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.horizontal(
                                      right: Radius.circular(25.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Yıllık',
                                    style: TextStyle(
                                      color: selectedSubscription == SubscriptionType.yearly
                                          ? Colors.white
                                          : Colors.white70,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 24.h),
                      
                      // Seçilen plan kartı
                      SubscriptionCard(
                        plan: plans[selectedSubscription]!,
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Satın alma butonu
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: ElevatedButton(
                    onPressed: () {
                      // Satın alma işlemi
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.background,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.w,
                        vertical: 18.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Subscribe Now',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.electricBlue.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.electricBlue,
              width: 1.5.w,
            ),
          ),
          child: Icon(
            icon,
            color: AppColors.electricBlue,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ],
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionPlan plan;

  const SubscriptionCard({
    super.key,
    required this.plan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: plan.isPopular 
              ? AppColors.electricBlue 
              : Colors.white24,
          width: 2.w,
        ),
        boxShadow: [
          BoxShadow(
            color: plan.isPopular 
                ? AppColors.electricBlue.withOpacity(0.3)
                : Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (plan.isPopular)
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.electricBlue,
                borderRadius: BorderRadius.vertical(top: Radius.circular(18.r)),
              ),
              child: Text(
                'Most Popular',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                Text(
                  plan.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 8.h),
                Text(
                  plan.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: plan.price,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: ' / ${plan.period}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Column(
                  children: plan.features.map((feature) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.electricBlue,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              feature,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}