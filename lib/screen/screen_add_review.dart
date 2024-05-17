import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController infoTextController = TextEditingController();
  bool _btnEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.appColors.backgroundColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: context.appColors.backgroundColor,
                scrolledUnderElevation: 0,
                toolbarHeight: appBarHeight,
              ),
              Expanded(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "수업을 들은 과목을 선택해주세요.",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Height(16),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "소중한 평가를 적어주세요.",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      child: SizedBox(
                        child: Form(
                          key: _formKey,
                          onChanged: () => setState(() {
                            _btnEnabled = _formKey.currentState!.validate();
                          }),
                          child: TextFormField(
                              controller: infoTextController,
                              style: const TextStyle(fontSize: 19),
                              maxLines: 100,
                              decoration: InputDecoration(
                                contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                filled: true,
                                fillColor: context.appColors.textFieldColor,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: context.appColors.primaryColor, width: 0.6),
                                    borderRadius: BorderRadius.circular(12)),
                                errorStyle: const TextStyle(fontSize: 15),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "필수 입력값입니다.";
                                }
                                return null;
                              }
                          ),
                        ),
                      ),
                    ),
                    const Height(240),
                    Consumer(builder: (context, ref, child) {
                      return MaterialButton(
                        onPressed: _btnEnabled
                            ? () {}
                            : null,
                        height: 48,
                        minWidth: double.infinity,
                        color: context.appColors.primaryColor,
                        disabledColor: context.appColors.textFieldColor,
                        shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
