import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui/onBoardingScreen/onBoardingScreen_pages/intro_page_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'onBoardingScreen_pages/intro_page_2.dart';
import 'onBoardingScreen_pages/intro_page_3.dart';

class OnBoardingScreen_1 extends StatefulWidget {
  const OnBoardingScreen_1({super.key});
  @override
  State<OnBoardingScreen_1> createState() => _OnBoardingScreen_1State();
}

class _OnBoardingScreen_1State extends State<OnBoardingScreen_1> {
  PageController _pageController =
      PageController(); // for keeping page controller.
  bool onLastPage = false; // for keeping tract if we are the last page.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) {
              // value holds the value in which page we are currently on. like -> 0,1,2
              setState(() {
                onLastPage = (value == 2); // 2 is the last page index.
              });
            },
            children: [
              // desing the page in here
              IntroPage_1(),
              IntroPage_2(),
              IntroPage_3(),
            ],
          ),
          // dot indicator
          Container(
              alignment: Alignment(0, 0.90),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: const Text("Skip"),
                    onTap: () {
                      _pageController.jumpToPage(2); // skips to the last page
                    },
                  ),
                  SmoothPageIndicator(controller: _pageController, count: 3),
                  if (onLastPage)
                    GestureDetector(
                      child: const Text("Done"),
                      onTap: () {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                    ),
                  if (!onLastPage)
                    GestureDetector(
                      child: const Text("Next"),
                      onTap: () {
                        _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                    ),
                ],
              )),
        ],
      ),
    );
  }
}
