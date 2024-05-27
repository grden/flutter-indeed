import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../common/constant.dart';
import '../common/extension/extension_context.dart';
import '../common/widget/widget_arrow.dart';
import '../common/widget/widget_sizedbox.dart';
import '../common/widget/widget_tap.dart';
import '../model/enums.dart';
import '../model/model_teacher.dart';
import '../model/model_user.dart';
import '../provider/provider_user.dart';

class AddReviewScreen extends ConsumerStatefulWidget {
  final Teacher teacher;
  const AddReviewScreen({super.key, required this.teacher});

  @override
  ConsumerState<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends ConsumerState<AddReviewScreen> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _contentTextController = TextEditingController();
  bool _btnEnabled = false;
  bool isLoading = false;

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
    return Scaffold(
      body: Container(
        color: context.appColors.backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                  backgroundColor: context.appColors.backgroundColor,
                  scrolledUnderElevation: 0,
                  toolbarHeight: appBarHeight,
                  leading: Tap(
                    onTap: () {
                      context.pop();
                    },
                    child: const Arrow(
                      direction: AxisDirection.left,
                      size: 24,
                    ),
                  ),
                  title: Text(
                    '${widget.teacher.displayName}님의 평가를 작성해주세요.',
                    style: const TextStyle(
                        fontSize: 21, fontWeight: FontWeight.w700),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "수업을 들은 과목을 선택해주세요.",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Height(16),
                      SizedBox(
                        width: double.infinity,
                        height: 160,
                        child: GridView.count(
                          primary: true,
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          children:
                              List.generate(isSelected.length, (newIndex) {
                            return Tap(
                                onTap: () {
                                  //set the toggle logic
                                  final isOneSelected = isSelected
                                          .where((element) => element)
                                          .length ==
                                      1;

                                  if (isOneSelected && isSelected[newIndex]) {
                                    return;
                                  }

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
                                },
                                child: Container(
                                  //width: 20,
                                  //height: 10,
                                  decoration: BoxDecoration(
                                      color: isSelected[newIndex]
                                          ? context.appColors.primaryColor
                                          : context.appColors.cardColor,
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.transparent),
                                      boxShadow: [
                                        context.appShadows.cardShadow
                                      ]),
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
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "소중한 평가를 적어주세요.",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Height(16),
                      Expanded(
                        child: SizedBox(
                          child: Form(
                            key: _formKey,
                            onChanged: () => setState(() {
                              _btnEnabled = _formKey.currentState!.validate();
                            }),
                            child: TextFormField(
                                controller: _contentTextController,
                                style: const TextStyle(fontSize: 19),
                                maxLines: 50,
                                maxLength: 500,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 12),
                                  filled: true,
                                  fillColor: context.appColors.textFieldColor,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: context.appColors.primaryColor,
                                          width: 0.6),
                                      borderRadius: BorderRadius.circular(12)),
                                  errorStyle: const TextStyle(fontSize: 15),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "필수 입력값입니다.";
                                  }
                                  return null;
                                }),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "평가 작성 후 수정이 불가하니 주의해주세요.",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: context.appColors.secondaryText),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Height(16),
                      Consumer(builder: (context, ref, child) {
                        return MaterialButton(
                          onPressed: _btnEnabled
                              ? () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  for (int i = 0; i < subjectList.length; i++) {
                                    if (isSelected[i] == true) {
                                      setupList
                                          .add(subjectList[i].subjectString);
                                    }
                                  }

                                  try {
                                    final result = await addReview();
                                    if (result) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor:
                                              context.appColors.primaryColor,
                                          content: Text(
                                            '평가가 정상적으로 작성되었습니다.',
                                            style: TextStyle(
                                              color:
                                                  context.appColors.inverseText,
                                              fontSize: 19,
                                            ),
                                          ),
                                        ));
                                        context.go('/');
                                      }
                                    }
                                  } finally {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              : null,
                          height: 48,
                          minWidth: double.infinity,
                          color: context.appColors.primaryColor,
                          disabledColor: context.appColors.textFieldColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            "등록",
                            style: TextStyle(
                                color: _btnEnabled
                                    ? context.appColors.inverseText
                                    : context.appColors.secondaryText,
                                fontSize: 19,
                                fontWeight: FontWeight.w700),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> addReview() async {
    final userCredential = ref.watch(userCredentialProvider);
    final UserData? user = (await ref.read(userDatabaseProvider).get()).data();

    await db
        .collection('users')
        .doc(widget.teacher.user.email)
        .collection('type')
        .doc('teacher')
        .collection('reviews')
        .doc(userCredential?.user?.email)
        .set({
      'subjects': setupList,
      'content': _contentTextController.text.trim(),
      'reviewer': userCredential?.user?.email,
      'gender': user?.gender.genderString,
      'age': user?.age,
      'time': Timestamp.fromDate(DateTime.now()),
    });
    return true;
  }
}
