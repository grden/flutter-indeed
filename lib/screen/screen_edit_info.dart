import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../common/constant.dart';
import '../common/extension/extension_context.dart';
import '../common/widget/widget_arrow.dart';
import '../common/widget/widget_tap.dart';
import '../provider/provider_user.dart';

class EditInfoScreen extends ConsumerStatefulWidget {
  final bool accountType;
  const EditInfoScreen({required this.accountType, super.key});

  @override
  ConsumerState<EditInfoScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends ConsumerState<EditInfoScreen> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _infoTextController = TextEditingController();
  bool _btnEnabled = false;
  bool isLoading = false;

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
                  title: const Text(
                    '소개 수정',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Form(
                            key: _formKey,
                            onChanged: () => setState(() {
                              _btnEnabled = _formKey.currentState!.validate();
                            }),
                            child: TextFormField(
                                controller: _infoTextController,
                                style: const TextStyle(fontSize: 19),
                                maxLines: 50,
                                maxLength: 500,
                                decoration: InputDecoration(
                                  hintText: "소개를 입력해 주세요.",
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
                      Consumer(builder: (context, ref, child) {
                        return MaterialButton(
                          onPressed: _btnEnabled
                              ? () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  try {
                                    final result = await editInfo();
                                    if (result) {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor:
                                              context.appColors.primaryColor,
                                          content: Text(
                                            '정상적으로 수정되었습니다.',
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
                            "수정하기",
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

  Future<bool> editInfo() async {
    UserCredential userCredential = ref.watch(userCredentialProvider)!;

    if (widget.accountType) {
      await db
          .collection('users')
          .doc(userCredential.user!.email)
          .collection('type')
          .doc('teacher')
          .update({"info": _infoTextController.text.trim()});
      return true;
    } else {
      await db
          .collection('users')
          .doc(userCredential.user!.email)
          .collection('type')
          .doc('student')
          .update({"info": _infoTextController.text.trim()});
      return true;
    }
  }
}
