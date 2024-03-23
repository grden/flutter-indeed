import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_arrow.dart';
import 'package:self_project/common/widget/widget_tap.dart';
import 'package:self_project/widget/widget_budget_setup.dart';
import 'package:self_project/widget/widget_image_setup.dart';
import 'package:self_project/widget/widget_name_setup.dart';
import 'package:self_project/widget/widget_subject_setup.dart';
import 'package:self_project/widget/widget_univ_setup.dart';

final indexStateProvider = StateProvider<int>((ref) {
  return 0;
});

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final CarouselController buttonCarouselController = CarouselController();
  late final List<Widget> widgetList = [
    NameSetup(buttonCarouselController),
    UnivSetup(buttonCarouselController),
    SubjectSetup(buttonCarouselController),
    BudgetSetup(buttonCarouselController),
    ImageSetup(buttonCarouselController),
  ];

  @override
  Widget build(BuildContext context) {
    int index = ref.watch(indexStateProvider);

    return Scaffold(
        body: Container(
      color: context.appColors.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: appBarHeight,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 240,
                      child: FAProgressBar(
                        currentValue: index.toDouble(),
                        maxValue: 4,
                        size: 10,
                        backgroundColor: context.appColors.textFieldColor,
                        progressColor: context.appColors.primaryColor,
                        animatedDuration: const Duration(milliseconds: 160),
                      ),
                    ),
                  ),
                  if (index != 0) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Tap(
                        onTap: () {
                          ref.read(indexStateProvider.notifier).state--;
                          buttonCarouselController.previousPage(
                              duration: const Duration(milliseconds: 240));
                          return ref.read(setupProvider.notifier).removeSetup();
                        },
                        child: const Arrow(
                          direction: AxisDirection.left,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            CarouselSlider(
                items: widgetList,
                options: CarouselOptions(
                  height: 600,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                ),
                carouselController: buttonCarouselController)
          ],
        ),
      ),
    ));
  }
}

final setupProvider =
    NotifierProvider<SetupNotifier, List<List<Object>>>(() => SetupNotifier());

class SetupNotifier extends Notifier<List<List<Object>>> {
  @override
  List<List<Object>> build() {
    return [];
  }

  void addSetup(List<Object> setup) {
    state = [...state, setup];
    print(state);
  }

  void removeSetup() {
    state = [for (int i = 0; i < state.length - 1; i++) state[i]];
    print(state);
  }
}
