import 'package:flutter/material.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/onboarding/presentation/views/widgets/page_view_item.dart';

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          SharedPrefsHelper.setBool(
                            'onBoardingSeen',
                            true,
                          );
                          Navigator.of(
                            context,
                          ).pushReplacementNamed(LoginView.routeName);
                        },
                        child: const Text(
                          "SKIP",
                          style: TextStyle(
                            color: Color(0XFF7a7a7a),
                            fontSize: 16,
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
                      return PageViewItem(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed:
                            _currentPage > 0
                                ? () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                }
                                : null,
                        child: const Text(
                          "BACK",
                          style: TextStyle(
                            color: Color(0XFF7a7a7a),
                            fontSize: 16,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryAccent,
                          minimumSize: const Size(90, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          if (_currentPage == _onBoardData.length - 1) {
                            SharedPrefsHelper.setBool(
                              'onBoardingSeen',
                              true,
                            );
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
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
