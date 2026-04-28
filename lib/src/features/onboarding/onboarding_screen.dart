import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:ryde_app/src/core/constants/assets/assets.gen.dart';
import 'package:ryde_app/src/core/utils/extensions.dart';
import 'package:ryde_app/src/features/onboarding/widgets/onboarding_widget.dart';
import 'package:ryde_app/src/widgets/app_default_spacing.dart';

import '../../core/theme/pallete.dart';
import '../auth/ui/screen/get_started_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppDefaultSpacing(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _pageController.jumpToPage(2),
                child: Text(
                  "Skip",
                  style: context.text.titleSmall?.copyWith(
                    color: Pallete.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (value) => setState(() {
                  _currentPage = value;
                }),
                controller: _pageController,
                children: [
                  OnboardingWidget(
                    image: Assets.images.onboarding1.image(
                      cacheWidth: context.width.toInt(),
                    ),
                    bigText: 'The best car in your hands with Ryde',
                    smallText:
                        'Discover the convenience of finding your perfect ride with our Ryde App',
                  ),
                  OnboardingWidget(
                    image: Assets.images.onboarding2.image(
                      cacheWidth: context.width.toInt(),
                    ),
                    bigText: 'The perfect ride is \njust a tap away!',
                    smallText:
                        'Your journey begins with Ryde. Find your ideal ride effortlessly.',
                  ),
                  OnboardingWidget(
                    image: Stack(
                      children: [
                        Positioned(
                          child: Assets.images.onboardBg.image(
                            cacheWidth: context.width.toInt(),
                          ),
                        ),
                        Assets.images.onboarding3.image(
                          cacheWidth: context.width.toInt(),
                        ),
                      ],
                    ),
                    bigText: "Your ride, your way. \nLet's get started!",
                    smallText:
                        'Enter your destination, sit back, and \nlet us take care of the rest.',
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => OnboardingIndicatorWidget(
                  currentPage: _currentPage,
                  pageIndex: index,
                ),
              ),
            ),
            const GutterLarge(),
            ElevatedButton(
              onPressed: () {
                if (_currentPage < 2) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                } else {
                  context.pushReplacement(const GetStartedScreen());
                }
              },
              child: Text(_currentPage < 2 ? 'Next' : 'Get started'),
            ),
            GutterExtraLarge(),
          ],
        ),
      ),
    );
  }
}

class OnboardingIndicatorWidget extends StatelessWidget {
  final int currentPage;
  final int pageIndex;
  const OnboardingIndicatorWidget({
    super.key,
    required this.currentPage,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = currentPage == pageIndex;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 30,
      height: 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: active ? Pallete.active : Pallete.inactive,
      ),
    );
  }
}
