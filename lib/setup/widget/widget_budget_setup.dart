import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/setup/screen/screen_teacher_setup.dart';
import 'dart:ui' as ui;

class BudgetSetup extends StatefulWidget {
  const BudgetSetup(
      this.buttonPageController, {
        super.key,
      });

  final PageController buttonPageController;

  @override
  State<BudgetSetup> createState() => _BudgetSetupState();
}

class _BudgetSetupState extends State<BudgetSetup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController budgetTextController = TextEditingController();

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
              child: Text('예상 시급을 입력해주세요.', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),)),
          const Height(24),
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Flexible(flex: 1, child: Text('시간 당', style: TextStyle(
                fontSize: 21, fontWeight: FontWeight.w500),)),
                const Width(16),
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    controller: budgetTextController,
                    keyboardType: TextInputType.number,
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
                          borderSide: BorderSide(
                              color: context.appColors.primaryColor, width: 0.6),
                          borderRadius: BorderRadius.circular(12)),
                      errorStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const Width(16),
                const Flexible(flex: 1, child: Text('만원', style: TextStyle(
                    fontSize: 21, fontWeight: FontWeight.w500),))
              ],
            ),
          ),
          const Spacer(),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(indexStateProvider.notifier).state++;

                  widget.buttonPageController
                      .nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeOutQuart);

                  return ref.read(setupProvider.notifier).addSetup([budgetTextController.text.trim()]);
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
}
