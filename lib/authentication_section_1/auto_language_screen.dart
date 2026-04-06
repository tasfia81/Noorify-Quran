import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'login_screen.dart';

class LanguageController extends GetxController {
  var selectedLanguageIndex = 0.obs;

  void selectLanguage(int index) {
    selectedLanguageIndex.value = index;
  }
}

class AutoLanguageScreen extends StatelessWidget {
  AutoLanguageScreen({super.key});

  final LanguageController controller = Get.put(LanguageController());

  final List<Map<String, String>> languages = [
    {'title': 'English', 'subtitle': 'Default'},
    {'title': 'Bangla', 'subtitle': 'বাংলা'},
    {'title': 'Arabic', 'subtitle': 'العربية'},
    {'title': 'Turkish', 'subtitle': 'Türkçe'},
    {'title': 'Urdu', 'subtitle': 'اردو'},
    {'title': 'French', 'subtitle': 'Français'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1A13),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Select Language',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            
            // Globe Icon
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: const BoxDecoration(
                color: Color(0xFF14291D), 
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.language_rounded,
                color: const Color(0xFF2BDB82),
                size: 32.sp,
              ),
            ),
            
            SizedBox(height: 20.h),
            
            // Description Text
            Text(
              'Choose your preferred language for the\nQuran translation and app interface.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF8A9A91),
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
            
            SizedBox(height: 25.h),
            
            // Search Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF132018),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: const Color(0xFF607366), size: 24.sp),
                  hintText: 'Search languages',
                  hintStyle: TextStyle(color: const Color(0xFF607366), fontSize: 16.sp),
                ),
              ),
            ),
            
            SizedBox(height: 25.h),
            
            // Language List
            Expanded(
              child: ListView.separated(
                itemCount: languages.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  return _buildLanguageOption(
                    title: languages[index]['title']!,
                    subtitle: languages[index]['subtitle']!,
                    index: index,
                  );
                },
              ),
            ),
            
            SizedBox(height: 10.h),
            
            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 55.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const LoginScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF358E3F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 30.h), // Bottom safe area padding
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String title,
    required String subtitle,
    required int index,
  }) {
    return Obx(() {
      bool isSelected = controller.selectedLanguageIndex.value == index;
      return GestureDetector(
        onTap: () => controller.selectLanguage(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF101E16),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? const Color(0xFF2A5237) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: const Color(0xFF6B7E72),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              // Radio Button
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected ? const Color(0xFF43A047) : const Color(0xFF1E3526),
                    width: 2,
                  ),
                  color: isSelected ? const Color(0xFF43A047) : Colors.transparent,
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
}
