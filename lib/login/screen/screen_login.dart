import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/login/widget/widget_signin_card.dart';
import 'package:self_project/login/widget/widget_signup_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final CarouselController buttonCarouselController = CarouselController();
  final PageController buttonPageController = PageController();
  late final List<Widget> widgetList = [
    SigninCard(buttonPageController),
    SignupCard(buttonPageController)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    color: context.appColors.primaryColor,
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    color: context.appColors.backgroundColor,
                  ),
                ),
              ],
            ),
            ExpandablePageView.builder(
              controller: buttonPageController,
              itemCount: widgetList.length,
              itemBuilder: (context, index) => widgetList[index],
              physics: const NeverScrollableScrollPhysics(),
            ),
            // CarouselSlider(
            //     items: widgetList,
            //     options: CarouselOptions(
            //       height: 680,
            //       initialPage: 0,
            //       viewportFraction: 1,
            //       enableInfiniteScroll: false,
            //       scrollPhysics: const NeverScrollableScrollPhysics(),
            //     ),
            //     carouselController: buttonCarouselController),
          ],
        ),
      ),
    );
  }
}
