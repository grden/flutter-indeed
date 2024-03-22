import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/common/widget/widget_tap.dart';
import 'package:self_project/model/model_teacher.dart';
import 'package:self_project/screen/screen_setup.dart';

class SubjectSetup extends StatefulWidget {
  const SubjectSetup(
    this.buttonCarouselController, {
    super.key,
  });

  final CarouselController buttonCarouselController;

  @override
  State<SubjectSetup> createState() => _SubjectSetupState();
}

class _SubjectSetupState extends State<SubjectSetup> {
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
  List<Subject> setupList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: context.appColors.backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Height(48),
          Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '가르치고자 하는\n과목을 선택해주세요.',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  )),
              const Height(16),
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
                    //using Inkwell widget to create a button
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
                            boxShadow: [context.appShadows.cardShadow]
                          ),
                          child: Center(
                            child: Text(
                              subjectList[newIndex].subjectString,
                              style: TextStyle(
                                  color: isSelected[newIndex]
                                      ? context.appColors.inverseText
                                      : context.appColors.primaryText,
                              fontSize: 17, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ));
                  }),
                ),
              )
            ],
          ),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: () {
                widget.buttonCarouselController
                    .nextPage(duration: const Duration(milliseconds: 240));
                ref.read(indexStateProvider.notifier).state++;

                for(int i=0; i < subjectList.length; i++) {
                  if(isSelected[i] == true) {
                    setupList.add(subjectList[i]);
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
