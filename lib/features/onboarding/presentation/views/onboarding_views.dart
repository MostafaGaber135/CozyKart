import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/onboarding/presentation/views/widgets/onboarding_page_item.dart';

class OnBoardingPageView extends StatefulWidget {
  const OnBoardingPageView({super.key});
  static const String routeName = '/OnBoardingPageView';

  @override
  State<OnBoardingPageView> createState() => _OnBoardingPageViewState();
}

class _OnBoardingPageViewState extends State<OnBoardingPageView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onBoardData = [
    {
      "image": "assets/images/onboarding_screen_one.png",
      "title": "Welcome to Furniture",
      "subTitle": "Find your perfect piece for your home and lifestyle",
    },
    {
      "image": "assets/images/onboarding_screen_two.png",
      "title": "High Quality Furniture",
      "subTitle": "Our design combines both comfort and elegance.",
    },
    {
      "image": "assets/images/onboarding_screen_three.png",
      "title": "Read Our Blog",
      "subTitle": "Get tips and trends about furniture from our blog",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await SharedPrefsHelper.setOnboardingSeen(true);
                          if (!context.mounted) return;
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(LoginView.routeName);
                        },
                        child: Text(
                          "SKIP",
                          style: TextStyle(
                            color: Color(0XFF7a7a7a),
                            fontSize: 16.sp,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _onBoardData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return OnboardingPageItem(
                        imagePath: _onBoardData[index]['image']!,
                        title: _onBoardData[index]['title']!,
                        subTitle: _onBoardData[index]['subTitle'] ?? '',
                        currentPage: _currentPage,
                        totalPages: _onBoardData.length,
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 15.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _currentPage > 0
                          ? TextButton(
                            onPressed: () {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },

                            child: Text(
                              "BACK",
                              style: TextStyle(
                                color: Color(0XFF7a7a7a),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                          : const SizedBox(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccent,
                          minimumSize: Size(90.w, 48.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        onPressed: () {
                          if (_currentPage == _onBoardData.length - 1) {
                            SharedPrefsHelper.setBool('onBoardingSeen', true);
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(LoginView.routeName);
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                        child: Text(
                          _currentPage == _onBoardData.length - 1
                              ? "GET STARTED"
                              : "NEXT",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
