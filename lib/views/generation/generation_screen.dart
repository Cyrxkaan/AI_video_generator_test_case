import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        decoration: BoxDecoration(
          gradient: AppColors.subtleGradient,
        ),
        child: SafeArea(
          child: isLoading
              ? _buildLoadingView()
              : _buildMainView(context, ref),
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
            // Geri butonu
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
            
            SizedBox(height: 16.h),
            
            // Başlık
            Text(
              'Video Oluştur',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            SizedBox(height: 8.h),
            
            Text(
              'AI ile video üretmek için görsel yükleyin',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            
            SizedBox(height: 48.h),
            
            // Görsel yükleme alanı
            _ImageUploadArea(ref: ref),
            
            SizedBox(height: 48.h),
            
            // Generate butonu
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
          ),
          
          SizedBox(height: 32.h),
          
          Text(
            'AI Video Oluşturuluyor...',
            style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
          ),
          
          SizedBox(height: 16.h),
          
          Text(
            'Bu işlem birkaç dakika sürebilir',
            style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.sp,
                ),
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

    // Loading state'i bitir ve mock sonuç göster
    ref.read(isLoadingProvider.notifier).state = false;
    ref.read(resultProvider.notifier).state = 'Mock Video Result';

    // Sonuç ekranına yönlendir
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResultScreen(),
      ),
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
        border: Border.all(
          color: AppColors.neonPurple,
          width: 2.w,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.upload_outlined,
            color: AppColors.neonPurple,
            size: 60.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'Görsel Yükle',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.neonPurple,
                ),
          ),
          SizedBox(height: 8.h),
          Text(
            'veya sürükleyip bırakın',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.neonPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: AppColors.neonPurple,
                width: 1.w,
              ),
            ),
            child: Text(
              'Dosya Seç',
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
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Geri butonu
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context); // Also pop the generation screen
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                
                SizedBox(height: 16.h),
                
                // Başlık
                Text(
                  'Video Oluşturuldu!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                
                SizedBox(height: 48.h),
                
                // Sonuç görseli
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
                        'AI Tarafından Oluşturulan Video',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.electricBlue,
                            ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 32.h),
                
                // Video bilgileri
                _VideoInfoCard(),
                
                SizedBox(height: 32.h),
                
                // Paylaş butonu
                ElevatedButton(
                  onPressed: () {
                    // Paylaş fonksiyonu
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
              ],
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
        border: Border.all(
          color: AppColors.neonPurple,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Video Detayları',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16.h),
          _InfoRow(label: 'Kalite:', value: '4K'),
          SizedBox(height: 8.h),
          _InfoRow(label: 'Format:', value: 'MP4'),
          SizedBox(height: 8.h),
          _InfoRow(label: 'Süre:', value: '30 saniye'),
          SizedBox(height: 8.h),
          _InfoRow(label: 'Boyut:', value: '15 MB'),
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white70,
              ),
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