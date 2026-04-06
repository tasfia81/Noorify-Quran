import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'auto_language_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    ///----------------- Setting up a dummy loading animation ----------------
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _progressAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Get.off(() => AutoLanguageScreen());
        }
      });

    // Start loading animation
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryGold = Color(0xFFF2C754);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 1.2,
            colors: [
              Color(0xFF0F3E25), // Lighter green at center
              Color(0xFF071B11), // Darkest green at edges
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background subtle stars
            Positioned(top: 150.h, left: 60.w, child: _buildDot(opacity: 0.3, size: 5)),
            Positioned(top: 250.h, right: 80.w, child: _buildDot(opacity: 0.5, size: 6)),
            Positioned(top: 500.h, right: 120.w, child: _buildDot(opacity: 0.4, size: 4)),
            Positioned(top: 600.h, left: 80.w, child: _buildCrossStar()),
            Positioned(bottom: 250.h, right: 60.w, child: _buildDot(opacity: 0.2, size: 5)),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),

                // Glowing Book Icon
                Container(
                  width: 140.w,
                  height: 140.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0D321F), // Dark inner
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF145331).withOpacity(0.8),
                        blurRadius: 50.r,
                        spreadRadius: 5.r,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.menu_book_rounded,
                      size: 65.sp,
                      color: primaryGold,
                    ),
                  ),
                ),
                
                SizedBox(height: 50.h),

                // Main Title - QURAN
                Text(
                  'Q U R A N',
                  style: TextStyle(
                    fontSize: 34.sp,
                    fontWeight: FontWeight.w700,
                    color: primaryGold,
                    letterSpacing: 4.0,
                    fontFamily: 'Roboto', // Change if you have a specific font family in pubspec
                  ),
                ),
                SizedBox(height: 10.h),

                // Subtitle - INTERNATIONAL
                Text(
                  'I N T E R N A T I O N A L',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: primaryGold,
                    letterSpacing: 6.0,
                  ),
                ),
                SizedBox(height: 25.h),

                // Arabic text
                Text(
                  'القرآن العالمية',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w500,
                    color: primaryGold,
                  ),
                ),

                const Spacer(flex: 2),

                // Loading Bar Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'LOADING...',
                            style: TextStyle(
                              color: primaryGold,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Text(
                            '${(_progressAnimation.value * 100).toInt()}%',
                            style: TextStyle(
                              color: primaryGold,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: LinearProgressIndicator(
                          value: _progressAnimation.value,
                          minHeight: 6.h,
                          backgroundColor: const Color(0xFF1E3827),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            primaryGold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 80.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required double opacity, required double size}) {
    return Container(
      width: size.w,
      height: size.w, // .w for both so it remains a perfect circle
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(opacity),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCrossStar() {
    return Transform.rotate(
      angle: 0.785398, // 45 degrees in radians
      child: Icon(
        Icons.add,
        color: Colors.white.withOpacity(0.15),
        size: 16.sp,
      ),
    );
  }
}
