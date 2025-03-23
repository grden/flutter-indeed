import 'dart:developer' as d;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import '../common/extension/extension_context.dart';
import '../common/widget/widget_arrow.dart';
import '../common/widget/widget_tap.dart';
import '../common/constant.dart';
import '../services/service_auth.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: Tap(
          onTap: () {
            context.pop();
          },
          child: const Arrow(
            direction: AxisDirection.left,
            size: 24,
          ),
        ),
        backgroundColor: context.appColors.backgroundColor,
        scrolledUnderElevation: 0,
        toolbarHeight: appBarHeight,
      ),
      body: Container(
        color: context.appColors.backgroundColor,
        child: SafeArea(
          child: ListView(
            children: [
              _logoutContainer(context),
              _delAccountContainer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoutContainer(BuildContext context) {
    return Tap(
        onTap: () {
          Dialogs.materialDialog(
              context: context,
              msg: '정말 로그아웃 하시겠습니까?',
              msgAlign: TextAlign.center,
              msgStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.primaryText),
              dialogShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: '취소',
                  textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.inverseText),
                  color: context.appColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(12),
                ),
                IconsOutlineButton(
                  onPressed: () async {
                    try {
                      await AuthService.logout();
                      await FirebaseAuth.instance.signOut();
                      //Navigator.popUntil(context, (route) => false);
                      context.go('/login');
                    } catch (e) {
                      d.log(e.toString());
                    }
                  },
                  text: '로그아웃',
                  textStyle: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.secondaryText),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.all(12),
                )
              ]);
        },
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            '로그아웃',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
          ),
        ));
  }

  Widget _delAccountContainer(BuildContext context) {
    return Tap(
      onTap: () {
        Dialogs.materialDialog(
            context: context,
            msg: '안돼요 \u{1F44E}',
            msgAlign: TextAlign.center,
            msgStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: context.appColors.primaryText),
            dialogShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: '확인',
                textStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.inverseText),
                color: context.appColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(12),
              ),
            ]);
      },
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '탈퇴하기',
          style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
