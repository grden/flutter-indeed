import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/setup/screen/screen_teacher_setup.dart';
import 'dart:ui' as ui;

class NameSetup extends StatefulWidget {
  const NameSetup(
    this.buttonPageController, {
    super.key,
  });

  final PageController buttonPageController;

  @override
  State<NameSetup> createState() => _NameSetupState();
}

class _NameSetupState extends State<NameSetup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();
  bool _btnEnabled = false;

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
              child: Text('학생들에게 보여질\n닉네임을 입력해주세요.', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)),
          const Height(24),
          Form(
            key: _formKey,
            onChanged: ()=>setState(() {
              _btnEnabled = _formKey.currentState!.validate();
            }),
            child: TextFormField(
              controller: nameTextController,
              style: const TextStyle(fontSize: 19),
              maxLength: 16,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                  return '필수 입력값입니다.';
                }
                return null;
              },
            ),
          ),
          const Spacer(),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: _btnEnabled ? () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.buttonPageController
                      .nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuart);
                  ref.read(indexStateProvider.notifier).state++;
                  return ref.read(setupProvider.notifier).addSetup([nameTextController.text.trim()]);
                }
              } : null,
              height: 48,
              minWidth: double.infinity,
              color: context.appColors.primaryColor,
              disabledColor: context.appColors.textFieldColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                '다음',
                style: TextStyle(
                    color: _btnEnabled ? context.appColors.inverseText : context.appColors.secondaryText,
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
