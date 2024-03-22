import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/screen/screen_setup.dart';

class NameSetup extends StatefulWidget {
  const NameSetup(
    this.buttonCarouselController, {
    super.key,
  });

  final CarouselController buttonCarouselController;

  @override
  State<NameSetup> createState() => _NameSetupState();
}

class _NameSetupState extends State<NameSetup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTextController = TextEditingController();

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
                  child: Text('학생들에게 보여질\n닉네임을 입력해주세요.', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),)),
              const Height(16),
              Form(
                key: _formKey,
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
            ],
          ),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.buttonCarouselController
                      .nextPage(duration: const Duration(milliseconds: 240));
                  ref.read(indexStateProvider.notifier).state++;
                  return ref.read(setupProvider.notifier).addSetup(nameTextController.text.trim());
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
