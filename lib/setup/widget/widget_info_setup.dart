import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/provider/provider_user.dart';
import 'package:self_project/setup/screen/screen_student_setup.dart';
import 'dart:ui' as ui;

class InfoSetup extends ConsumerStatefulWidget {
  const InfoSetup(
    this.buttonPageController, {
    super.key,
  });

  final PageController buttonPageController;

  @override
  ConsumerState<InfoSetup> createState() => _InfoSetupState();
}

class _InfoSetupState extends ConsumerState<InfoSetup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController infoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final availHeight = MediaQuery.of(context).size.height -
        appBarHeight -
        MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!)
            .padding
            .top -
        MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!)
            .padding
            .bottom;
    return Container(
      height: availHeight,
      padding: const EdgeInsets.all(24),
      color: context.appColors.backgroundColor,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              '본인에 대한 자세한 소개를\n입력해주세요.',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
          // const Height(4),
          // Align(
          //   alignment: Alignment.center,
          //   child: Text(
          //     '현재 점수, 목표, 선호하는 수업 방식, 성격 등의 정보를 입력하여 본인과 맞는 선생님을 만나세요',
          //     style: TextStyle(
          //         fontSize: 17,
          //         fontWeight: FontWeight.w400,
          //         color: context.appColors.secondaryText),
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          const Height(24),
          Expanded(
            child: SizedBox(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: infoTextController,
                  style: const TextStyle(fontSize: 19),
                  maxLines: 100,
                  decoration: InputDecoration(
                    hintText: "현재 점수, 목표, 선호하는 수업 방식, 성격 등의 정보를 입력하여 본인과 맞는 선생님을 만나세요.",
                    hintStyle: TextStyle(color: context.appColors.secondaryText, fontSize: 17, fontWeight: FontWeight.w400),
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
                      return '필수 입력값입니다.';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          const Height(72),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(indexStateProvider.notifier).state++;

                  ref
                      .read(setupProvider.notifier)
                      .addSetup([infoTextController.text.trim()]);

                  addSetup();

                  context.go('/');
                }
              },
              height: 48,
              minWidth: double.infinity,
              color: context.appColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                '설정 완료하기',
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

  Future addSetup() async {
    final userCredential = ref.watch(userCredentialProvider);
    final setupList = ref.read(setupProvider);

    await db
        .collection('users')
        .doc(userCredential?.user?.email)
        .collection('type')
        .doc('student')
        .set({
      'subjects': setupList[0],
      'info': setupList[1][0].toString(),
    });

    await db
        .collection('users')
        .doc(userCredential?.user?.email)
        .update({'initialSetup': true});
  }
}
