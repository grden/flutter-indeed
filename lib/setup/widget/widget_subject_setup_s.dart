import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/common/widget/widget_tap.dart';
import 'package:self_project/model/enums.dart';
import 'package:self_project/setup/screen/screen_student_setup.dart';
import 'dart:ui' as ui;

class SubjectSetupS extends ConsumerStatefulWidget {
  const SubjectSetupS(
      this.buttonPageController, {
        super.key,
      });

  final PageController buttonPageController;

  @override
  ConsumerState<SubjectSetupS> createState() => _SubjectSetupState();
}

class _SubjectSetupState extends ConsumerState<SubjectSetupS> {
  List<bool> isSelected = [true, false, false, false, false, false, false];
  List<Subject> subjectList = [
    Subject.math,
    Subject.english,
    Subject.korean,
    Subject.science,
    Subject.society,
    Subject.essay,
    Subject.others
  ];
  List<String> setupList = [];

  @override
  Widget build(BuildContext context) {
    final availHeight = MediaQuery.of(context).size.height - appBarHeight - MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!).padding
        .top - MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!).padding.bottom;
    return Container(
      height: availHeight,
      padding: const EdgeInsets.all(24),
      color: context.appColors.backgroundColor,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              '배우고자 하는\n과목을 선택해주세요.',
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          const Height(24),
          SizedBox(
            width: double.infinity,
            height: 300,
            child: GridView.count(
              primary: true,
              crossAxisCount: 3,
              //set the number of buttons in a row
              crossAxisSpacing: 16,
              //set the spacing between the buttons
              mainAxisSpacing: 16,
              childAspectRatio: 2,
              //set the width-to-height ratio of the button,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(isSelected.length, (newIndex) {
                return Tap(
                    onTap: () {
                      //set the toggle logic
                      final isOneSelected =
                          isSelected.where((element) => element).length ==
                              1;

                      if (isOneSelected && isSelected[newIndex]) return;

                      setState(() {
                        // looping through the list of booleans
                        for (int index = 0;
                        index < isSelected.length;
                        index++) {
                          // checking for the index value
                          if (index == newIndex) {
                            // toggle between the old index and new index value
                            isSelected[index] = !isSelected[index];
                          }
                        }
                      });
                      //print(isSelected);
                    },
                    child: Container(
                      //width: 20,
                      //height: 10,
                      decoration: BoxDecoration(
                          color: isSelected[newIndex]
                              ? context.appColors.primaryColor
                              : context.appColors.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.transparent),
                          boxShadow: [context.appShadows.cardShadow]),
                      child: Center(
                        child: Text(
                          subjectList[newIndex].subjectString,
                          style: TextStyle(
                              color: isSelected[newIndex]
                                  ? context.appColors.inverseText
                                  : context.appColors.primaryText,
                              fontSize: 17,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ));
              }),
            ),
          ),
          const Spacer(),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: () {
                widget.buttonPageController
                    .nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuart);
                ref.read(indexStateProvider.notifier).state++;

                for (int i = 0; i < subjectList.length; i++) {
                  if (isSelected[i] == true) {
                    setupList.add(subjectList[i].subjectString);
                  }
                }
                return ref.read(setupProvider.notifier).addSetup(setupList);
              },
              height: 48,
              minWidth: double.infinity,
              color: context.appColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                '다음',
                style: TextStyle(
                    color: context.appColors.inverseText,
                    fontSize: 19,
                    fontWeight: FontWeight.w700),
              ),
            );
          }),
        ],
      ),
    );
  }
}
