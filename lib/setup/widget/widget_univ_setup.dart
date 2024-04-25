import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/setup/screen/screen_teacher_setup.dart';
import 'dart:ui' as ui;

class UnivSetup extends StatefulWidget {
  const UnivSetup(
    this.buttonCarouselController, {
    super.key,
  });

  final PageController buttonCarouselController;

  @override
  State<UnivSetup> createState() => _UnivSetupState();
}

class _UnivSetupState extends State<UnivSetup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController univTextController = TextEditingController();
  TextEditingController majorTextController = TextEditingController();
  TextEditingController studentIDTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final availHeight = MediaQuery.of(context).size.height - appBarHeight - MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!).padding
        .top - MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!).padding.bottom;
    return Container(
      height: availHeight,
      padding: const EdgeInsets.all(24),
      color: context.appColors.backgroundColor,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              '대학 정보를 입력해주세요.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          const Height(24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(flex: 3, child: univTextFormField(context)),
                    const Width(8),
                    const Flexible(
                      flex: 1,
                      child: Text(
                        '대학교',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Width(24),
                  ],
                ),
                const Height(16),
                Row(
                  children: [
                    Flexible(flex: 3, child: majorTextFormField(context)),
                    const Width(8),
                    const Flexible(
                      flex: 1,
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                    const Width(24),
                  ],
                ),
                const Height(16),
                Row(
                  children: [
                    Flexible(
                        flex: 3, child: studentIDTextFormField(context)),
                    const Width(8),
                    const Flexible(
                      flex: 1,
                      child: Text(
                        '학번',
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const Width(24),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.buttonCarouselController
                      .nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuart);
                  ref.read(indexStateProvider.notifier).state++;

                  final List<String> univInfo = [
                    univTextController.text.trim(),
                    majorTextController.text.trim(),
                    studentIDTextController.text.trim()
                  ];

                  return ref.read(setupProvider.notifier).addSetup(univInfo);
                }
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

  TextFormField univTextFormField(BuildContext context) => TextFormField(
        controller: univTextController,
        style: const TextStyle(fontSize: 19),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          filled: true,
          fillColor: context.appColors.textFieldColor,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.appColors.primaryColor, width: 0.6),
              borderRadius: BorderRadius.circular(12)),
          labelText: '학교명',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return '필수 입력값입니다.';
        //   }
        //   return null;
        // },
      );

  TextFormField majorTextFormField(BuildContext context) => TextFormField(
        controller: majorTextController,
        style: const TextStyle(fontSize: 19),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          filled: true,
          fillColor: context.appColors.textFieldColor,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.appColors.primaryColor, width: 0.6),
              borderRadius: BorderRadius.circular(12)),
          labelText: '학과',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return '필수 입력값입니다.';
        //   }
        //   return null;
        // },
      );

  TextFormField studentIDTextFormField(BuildContext context) => TextFormField(
        controller: studentIDTextController,
        style: const TextStyle(fontSize: 19),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          filled: true,
          fillColor: context.appColors.textFieldColor,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.appColors.primaryColor, width: 0.6),
              borderRadius: BorderRadius.circular(12)),
          labelText: '학번',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return '필수 입력값입니다.';
        //   }
        //   return null;
        // },
      );
}
