import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/provider/provider_user.dart';
import 'package:self_project/setup/screen/screen_student_setup.dart';

class InfoSetup extends ConsumerStatefulWidget {
  const InfoSetup(
      this.buttonCarouselController, {
        super.key,
      });

  final CarouselController buttonCarouselController;

  @override
  ConsumerState<InfoSetup> createState() => _InfoSetupState();
}

class _InfoSetupState extends ConsumerState<InfoSetup> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController infoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: context.appColors.backgroundColor,
      child: Column(
        children: [
          const Height(48),
          Column(
            children: [
              const Height(40),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('본인에 대한 소개를 입력해주세요.', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),)),
              const Height(4),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('현재 점수, 목표, 선호하는 수업 방식, 성격 등의 정보를 입력하여 본인과 맞는 선생님을 만나세요', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w400, color: context.appColors.secondaryText),)),
              const Height(24),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: infoTextController,
                  style: const TextStyle(fontSize: 19),
                  maxLines: 8,
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
                      return '필수 입력값입니다.';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const Spacer(),
          Consumer(builder: (context, ref, child) {
            return MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  ref.read(indexStateProvider.notifier).state++;

                  ref.read(setupProvider.notifier).addSetup([infoTextController.text.trim()]);

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
      'info' : setupList[1][0].toString(),
    });

    await db.collection('users').doc(userCredential?.user?.email).update({'initialSetup' : true});
  }
}
