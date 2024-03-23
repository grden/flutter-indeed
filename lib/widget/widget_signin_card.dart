import 'package:carousel_slider/carousel_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/provider/provider_user.dart';

class SigninCard extends StatefulWidget {
  const SigninCard(
    this.buttonCarouselController, {
    super.key,
  });

  final CarouselController buttonCarouselController;

  @override
  State<SigninCard> createState() => _SigninCardState();
}

class _SigninCardState extends State<SigninCard> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        //height: 500,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: context.appColors.cardColor,
            boxShadow: [context.appShadows.cardShadow]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailTextController,
                    style: const TextStyle(fontSize: 19),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      filled: true,
                      fillColor: context.appColors.textFieldColor,
                      prefixIcon: const Icon(Icons.mail),
                      iconColor: context.appColors.primaryText,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: context.appColors.primaryColor,
                              width: 0.6),
                          borderRadius: BorderRadius.circular(12)),
                      labelText: '이메일',
                      labelStyle: TextStyle(
                          fontSize: 19, color: context.appColors.secondaryText),
                      errorStyle: const TextStyle(fontSize: 15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '이메일을 입력하세요';
                      }
                      return null;
                    },
                  ),
                  const Height(16),
                  TextFormField(
                    controller: pwdTextController,
                    style: const TextStyle(fontSize: 19),
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      filled: true,
                      fillColor: context.appColors.textFieldColor,
                      prefixIcon: const Icon(Icons.lock),
                      iconColor: context.appColors.primaryText,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: context.appColors.primaryColor,
                              width: 0.6),
                          borderRadius: BorderRadius.circular(12)),
                      labelText: '비밀번호',
                      labelStyle: TextStyle(
                          fontSize: 19, color: context.appColors.secondaryText),
                      errorStyle: const TextStyle(fontSize: 15),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '비밀번호를 입력하세요';
                      }
                      return null;
                    },
                  ),
                  const Height(16),
                  Consumer(builder: (context, ref, child) {
                    return MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          final userCredential = await signIn(
                              emailTextController.text.trim(),
                              pwdTextController.text.trim());
                          if (userCredential == null) {
                            return;
                          }

                          ref.read(userCredentialProvider.notifier).state =
                              userCredential;

                          final UserData? user =
                              (await ref.read(userDatabaseProvider).get())
                                  .data();
                          if (context.mounted) {
                            if (user?.accountType == null) {
                              context.go('/login/initial');
                            } else {
                              if (user?.initialSetup == false) {
                                context.go('/login/initial/setup');
                              } else
                                context.go('/');
                            }
                          }
                        }
                      },
                      height: 48,
                      minWidth: double.infinity,
                      color: context.appColors.primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                            color: context.appColors.inverseText,
                            fontSize: 19,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  }),
                  const Height(4),
                  // TextButton(
                  //   onPressed: () {},
                  //   style: ButtonStyle(
                  //     foregroundColor: MaterialStateProperty.all(
                  //         context.appColors.secondaryText),
                  //     overlayColor:
                  //     MaterialStateProperty.all(Colors.transparent),
                  //   ),
                  //   child: const Text(
                  //     '비밀번호 찾기',
                  //     style:
                  //     TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  //   ),
                  // ),
                  TextButton(
                    onPressed: () => widget.buttonCarouselController
                        .nextPage(duration: const Duration(milliseconds: 160)),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                          context.appColors.primaryColor),
                      overlayColor:
                          MaterialStateProperty.all(Colors.transparent),
                    ),
                    child: const Text(
                      '계정이 없나요? 회원가입',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SnackBar errorSnackbar(String errorText) => SnackBar(
        content: Text(
          errorText,
          style: TextStyle(color: context.appColors.inverseText, fontSize: 19),
        ),
        backgroundColor: context.appColors.errorColor,
      );

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackbar('해당 계정을 찾을 수 없습니다.'));
        }
      } else if (e.code == 'wrong-password') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackbar('비밀번호가 틀렸습니다.'));
        }
      } else if (e.code == 'invalid-email') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackbar('올바른 이메일 형식을 입력해주세요.'));
        }
      }
    } catch (e) {
      if (!context.mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(e.toString()));
    }
  }
}
