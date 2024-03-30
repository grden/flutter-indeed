import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_tap.dart';
import 'package:self_project/provider/provider_user.dart';

class ClassifyScreen extends ConsumerStatefulWidget {
  const ClassifyScreen({super.key});

  @override
  ConsumerState<ClassifyScreen> createState() => _ClassifyScreenState();
}

class _ClassifyScreenState extends ConsumerState<ClassifyScreen> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final userCredential = ref.watch(userCredentialProvider);

    return Scaffold(
        body: SafeArea(
      top: false,
      bottom: false,
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Tap(
              onTap: () {
                db
                    .collection('users')
                    .doc(userCredential?.user?.email)
                    .update({'accountType': true});
                db
                    .collection('users')
                    .doc(userCredential?.user?.email)
                    .collection('type')
                    .doc('teacher')
                    .set({'displayName' : ''});
                ref.read(accountTypeProvider.notifier).state = true;
                context.go('/login/initial/setup');
              },
              child: Container(
                color: context.appColors.primaryColor,
                child: Center(
                    child: Text(
                  '\u{1f480} 선생님으로 가입할게요',
                  style: TextStyle(
                      fontSize: 32,
                      color: context.appColors.inverseText,
                      fontWeight: FontWeight.w700),
                )),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Tap(
              onTap: () {
                db
                    .collection('users')
                    .doc(userCredential?.user?.email)
                    .update({'accountType': false});
                db
                    .collection('users')
                    .doc(userCredential?.user?.email)
                    .collection('type')
                    .doc('student')
                    .set({'displayName' : ''});
                ref.read(accountTypeProvider.notifier).state = false;
                context.go('login/initial/setup');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: context.appColors.backgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular((48))),
                ),
                child: Center(
                  child: Text(
                    '\u{1f393} 학생으로 가입할게요',
                    style: TextStyle(
                        fontSize: 32,
                        color: context.appColors.primaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
