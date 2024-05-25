import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

import 'data_onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    //final colorScheme = Theme.of(context).colorScheme;
    //final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;

    return Scaffold(
      body: Container(
        color: context.appColors.backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: onboardingData.length,
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingWidget(
                    assetPathLight: onboardingData[index].assetPathLight,
                    title: onboardingData[index].title,
                    subTitle: onboardingData[index].subTitle,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(onboardingData.length, (index) {
                  return Indicator(isActive: index == _pageIndex);
                }),
              ],
            ),
            const Height(12),
            //const Divider(thickness: .2),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: context.appColors.backgroundColor,
        child: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeOutBack,
            child: _pageIndex < 2
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [context.appShadows.cardShadow]),
                        child: FilledButton(
                          onPressed: () {
                            _pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          },
                          style: FilledButton.styleFrom(
                              backgroundColor: context.appColors.cardColor,
                              fixedSize: Size(size.width * 0.42, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          child: Text(
                            "스킵",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: context.appColors.primaryText,
                            ),
                          ),
                        ),
                      ),
                      FilledButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: context.appColors.primaryColor,
                            fixedSize: Size(size.width * 0.42, 48),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Text(
                          "다음",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                              color: context.appColors.inverseText),
                        ),
                      ),
                    ],
                  )
                : FilledButton(
                    onPressed: () => context.go('/login'),
                    style: FilledButton.styleFrom(
                        backgroundColor: context.appColors.primaryColor,
                        fixedSize: Size(size.width * 0.9, 48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      "시작하기",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          color: context.appColors.inverseText),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({
    super.key,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 200,
      ),
      curve: Curves.easeOut,
      width: isActive ? 30 : 8,
      height: 8,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: isActive
            ? context.appColors.primaryColor
            : context.appColors.textFieldColor,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingWidget extends StatelessWidget {
  final String assetPathLight;
  final String title;
  final String subTitle;

  const OnboardingWidget(
      {super.key,
      required this.assetPathLight,
      k,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    //final theme = Theme.of(context);
    //final isDark = MediaQuery.platformBrightnessOf(context) == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipPath(
          clipper: ArcClipper(),
          child: Stack(
            children: [
              Container(
                height: size.height * 0.55,
                decoration: BoxDecoration(
                  color: context.appColors.primaryColor,
                ),
              ),
              Positioned(
                bottom: -30,
                left: 0,
                right: 0,
                child: FadeInSlide(
                  duration: .0,
                  fadeOffset: size.height * 0.25,
                  direction: FadeSlideDirection.btt,
                  curve: Curves.easeOutBack,
                  child: Image.asset(
                    assetPathLight,
                    height: size.height * 0.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: size.height * 0.02),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FadeInSlide(
            duration: .5,
            fadeOffset: 60,
            curve: Curves.easeOutBack,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: context.appColors.primaryText),
            ),
          ),
        ),
        //SizedBox(height: size.height * 0.02),
        const Height(16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: FadeInSlide(
            duration: .5,
            fadeOffset: 60,
            curve: Curves.easeOutBack,
            child: Text(subTitle,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.secondaryText)),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

enum FadeSlideDirection { ttb, btt, ltr, rtl }

class FadeInSlide extends StatefulWidget {
  const FadeInSlide({
    super.key,
    required this.child,
    required this.duration,
    this.curve = Curves.easeInOutBack,
    this.fadeOffset = 40,
    this.direction = FadeSlideDirection.ttb,
  });

  final Widget child;
  final double duration;
  final double fadeOffset;
  final Curve curve;
  final FadeSlideDirection direction;

  @override
  State<FadeInSlide> createState() => _FadeInSlideState();
}

class _FadeInSlideState extends State<FadeInSlide>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacityAnimation;
  late Animation<double> inAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(milliseconds: (1000 * widget.duration).toInt()),
        vsync: this);
    inAnimation = Tween<double>(begin: -widget.fadeOffset, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ),
    )..addListener(() {
        setState(() {});
      });

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    controller.forward();
    return Transform.translate(
      offset: switch (widget.direction) {
        FadeSlideDirection.ltr => Offset(inAnimation.value, 0),
        FadeSlideDirection.rtl => Offset(size.width - inAnimation.value, 0),
        FadeSlideDirection.ttb => Offset(0, inAnimation.value),
        FadeSlideDirection.btt => Offset(0, 0 - inAnimation.value),
      },
      child: Opacity(
        opacity: opacityAnimation.value,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, size.height * 0.9)
      ..arcToPoint(Offset(size.width, size.height * 0.9),
          radius: Radius.circular(size.height), clockwise: false)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    //..arcToPoint(Offset(size.width, size.height * 0.9),
    // radius: Radius.circular(size.height), clockwise: false)

    // ..conicTo(size.width / 2, size.height, size.width, size.height * 0.9, 2)
    // ..quadraticBezierTo(
    //     size.width / 2, size.height, size.width, size.height * 0.8)
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
