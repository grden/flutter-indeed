import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grpc/grpc.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/services/auth.dart';

class SignupCard extends StatefulWidget {
  const SignupCard(
    this.buttonPageController, {
    super.key,
  });

  final PageController buttonPageController;

  @override
  State<SignupCard> createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _pwdTextController = TextEditingController();
  final _nameTextController = TextEditingController();
  final _ageTextController = TextEditingController();
  String? genderDropdownValue;
  String? locationDropdownValue;
  bool isLoading = false;

  //DateTime? onlineTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: double.infinity,
      height: 640,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: context.appColors.backgroundColor,
          boxShadow: [context.appShadows.cardShadow]),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      emailTextFormField(context),
                      const Height(16),
                      pwdTextFormField(context),
                      const Height(16),
                      const Line(),
                      const Height(16),
                      nameTextFormField(context),
                      const Height(16),
                      Row(
                        children: [
                          Expanded(child: ageTextFormField(context)),
                          const Width(12),
                          Expanded(
                              child: genderDropdownButtonFormField(context)),
                        ],
                      ),
                      const Height(16),
                      locationDropdownButtonFormField(context),
                      const Height(16),
                      MaterialButton(
                        onPressed: () async {
                          // setState(() {
                          //   onlineTime = DateTime.now();
                          // });
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            // try {
                            //   setState(() {
                            //     isLoading = true;
                            //   });

                            //   // text값으로 mongodb 계정 생성
                            //   final mongoUser = await AuthService.signup(
                            //       _emailTextController.text.trim(),
                            //       _pwdTextController.text.trim(),
                            //       _nameTextController.text.trim());

                            //   // email값의 doc 이름으로 firestore에 doc생성하여 text값 저장
                            //   final firestoreUser = {
                            //     'id': mongoUser?.id ?? '',
                            //     'email': mongoUser?.email ?? '',
                            //     'name': _nameTextController.text.trim(),
                            //     'age':
                            //         int.parse(_ageTextController.text.trim()),
                            //     'gender': genderDropdownValue!.trim(),
                            //     'locations': locationDropdownValue!.trim(),
                            //     'onlineTime':
                            //         Timestamp.fromDate(DateTime.now()),
                            //     //'onlineTime': DateTime.now().millisecondsSinceEpoch,
                            //     'accountType': null,
                            //     'initialSetup': false
                            //   };

                            //   await db
                            //       .collection('users')
                            //       .doc(_emailTextController.text.trim())
                            //       .set(firestoreUser)
                            //       .onError((error, _) => print(error));

                            //   if (mongoUser != null) {
                            //     if (context.mounted) {
                            //       ScaffoldMessenger.of(context)
                            //           .showSnackBar(SnackBar(
                            //         backgroundColor:
                            //             context.appColors.primaryColor,
                            //         content: Text(
                            //           '성공! 해당 계정으로 로그인해주세요.',
                            //           style: TextStyle(
                            //             color: context.appColors.inverseText,
                            //             fontSize: 19,
                            //           ),
                            //         ),
                            //       ));
                            //     }
                            //   }
                            // } on GrpcError catch (error) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       errorSnackbar(error.message.toString()));
                            // } finally {
                            //   if (mounted) {
                            //     setState(() {
                            //       isLoading = false;
                            //     });
                            //   }
                            // }

                            final result = await signUp(
                              _emailTextController.text.trim(),
                              _pwdTextController.text.trim(),
                              _nameTextController.text.trim(),
                              int.parse(_ageTextController.text.trim()),
                              genderDropdownValue!.trim(),
                              locationDropdownValue!.trim(),
                            );
                            if (result) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  backgroundColor:
                                      context.appColors.primaryColor,
                                  content: Text(
                                    '성공! 해당 계정으로 로그인해주세요.',
                                    style: TextStyle(
                                      color: context.appColors.inverseText,
                                      fontSize: 19,
                                    ),
                                  ),
                                ));
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
                          '회원가입',
                          style: TextStyle(
                              color: context.appColors.inverseText,
                              fontSize: 19,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Height(4),
                      TextButton(
                        onPressed: () => widget.buttonPageController
                            .previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutQuart),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              context.appColors.primaryColor),
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: const Text(
                          '뒤로가기',
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  TextFormField emailTextFormField(BuildContext context) => TextFormField(
        controller: _emailTextController,
        style: const TextStyle(fontSize: 19),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          filled: true,
          fillColor: context.appColors.textFieldColor,
          prefixIcon: const Icon(Icons.mail),
          iconColor: context.appColors.primaryText,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.appColors.primaryColor, width: 0.6),
              borderRadius: BorderRadius.circular(12)),
          labelText: '이메일',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '이메일을 입력하세요';
          }
          return null;
        },
      );

  TextFormField pwdTextFormField(BuildContext context) => TextFormField(
        controller: _pwdTextController,
        style: const TextStyle(fontSize: 19),
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          filled: true,
          fillColor: context.appColors.textFieldColor,
          prefixIcon: const Icon(Icons.lock),
          iconColor: context.appColors.primaryText,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: context.appColors.primaryColor, width: 0.6),
              borderRadius: BorderRadius.circular(12)),
          labelText: '비밀번호',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '비밀번호를 입력하세요';
          }
          return null;
        },
      );

  TextFormField nameTextFormField(BuildContext context) => TextFormField(
        controller: _nameTextController,
        style: const TextStyle(fontSize: 19),
        keyboardType: TextInputType.name,
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
          labelText: '이름',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '필수 입력값입니다.';
          }
          return null;
        },
      );

  TextFormField ageTextFormField(BuildContext context) => TextFormField(
        controller: _ageTextController,
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
          labelText: '나이',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '필수 입력값입니다.';
          }
          return null;
        },
      );

  DropdownButtonFormField genderDropdownButtonFormField(BuildContext context) =>
      DropdownButtonFormField(
        value: genderDropdownValue,
        items: <Gender>[Gender.male, Gender.female]
            .map((value) => DropdownMenuItem<String>(
                  value: value.genderString,
                  child: Text(value.genderString),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            genderDropdownValue = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '필수 입력값입니다.';
          }
          return null;
        },
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
          labelText: '성별',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        style: TextStyle(fontSize: 19, color: context.appColors.primaryText),
      );

  DropdownButtonFormField locationDropdownButtonFormField(
          BuildContext context) =>
      DropdownButtonFormField(
        value: locationDropdownValue,
        items: <Location>[Location.seoul, Location.gyeonggi]
            .map((value) => DropdownMenuItem<String>(
                  value: value.locationString,
                  child: Text(value.locationString),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            locationDropdownValue = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '필수 입력값입니다.';
          }
          return null;
        },
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
          labelText: '지역',
          labelStyle:
              TextStyle(fontSize: 19, color: context.appColors.secondaryText),
          errorStyle: const TextStyle(fontSize: 15),
        ),
        style: TextStyle(fontSize: 19, color: context.appColors.primaryText),
      );

  SnackBar errorSnackbar(String errorText) => SnackBar(
        content: Text(
          errorText,
          style: TextStyle(color: context.appColors.inverseText, fontSize: 19),
        ),
        backgroundColor: context.appColors.errorColor,
      );

  Future<bool> addToFirestore(Map<String, Object?> firestoreUser) async {
    try {
      db
          .collection('users')
          .doc(_emailTextController.text.trim())
          .set(firestoreUser)
          .onError((error, _) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackbar(error.toString()));
        }
      });
      return true;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(e.toString()));
      }
      return false;
    }
  }

  Future<bool> signUp(String emailAddress, String password, String name,
      int age, String gender, String locations) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      final mongoUser = await AuthService.signup(
          _emailTextController.text.trim(),
          _pwdTextController.text.trim(),
          _nameTextController.text.trim());

      db.collection('users').doc(emailAddress).set({
        'id': credential.user?.uid ?? '',
        'email': credential.user?.email ?? '',
        'name': name,
        'age': age,
        'gender': gender,
        'locations': locations,
        'onlineTime': Timestamp.fromDate(DateTime.now()),
        //'onlineTime': DateTime.now().millisecondsSinceEpoch,
        'accountType': null,
        'initialSetup': false
      });
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackbar('비밀번호가 약합니다.'));
        }
      } else if (e.code == 'email-already-in-use') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackbar('이미 정보가 존재합니다.'));
        }
      } else if (e.code == 'invalid-email') {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(errorSnackbar('올바른 이메일 형식을 입력해주세요.'));
        }
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(errorSnackbar(e.toString()));
      }
      return false;
    }
  }
}
