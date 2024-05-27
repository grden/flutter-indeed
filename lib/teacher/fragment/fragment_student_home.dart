import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../common/constant.dart';
import '../../common/extension/extension_context.dart';
import '../../model/model_student.dart';
import '../../model/model_user.dart';
import '../widget/widget_student_card.dart';
import '../../common/widget/widget_home_appbar.dart';
import '../../common/widget/widget_tap.dart';

class StudentHomeFragment extends ConsumerStatefulWidget {
  const StudentHomeFragment({super.key});

  @override
  ConsumerState<StudentHomeFragment> createState() =>
      _StudentHomeFragmentState();
}

class _StudentHomeFragmentState extends ConsumerState<StudentHomeFragment> {
  final db = FirebaseFirestore.instance;
  Stream<List<Student>>? studentStream;

  @override
  void initState() {
    super.initState();
    studentStream = getStudentStream();
  }

  void retryLoad() {
    setState(() {
      studentStream = getStudentStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.backgroundColor,
      child: Stack(
        children: [
          StreamBuilder(
            stream: studentStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Student> studentsList = snapshot.data!;
                if (studentsList.isEmpty) {
                  return const Center(
                      child: Text(
                    '아직 프로필을 열람한 학생이 없습니다 \u{1f480} ',
                    style: TextStyle(fontSize: 19),
                  ));
                } else {
                  return MasonryGridView.count(
                      padding: const EdgeInsets.fromLTRB(
                          16, appBarHeight + 16, 16, 60),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemCount: studentsList.length,
                      itemBuilder: (context, index) {
                        final student = studentsList[index];
                        return Tap(
                            onTap: () {
                              context.goNamed('student-profile',
                                  extra: student,
                                  pathParameters: {'id': student.user.id});
                            },
                            child: BuildStudentCard(student));
                      });
                }
              }
              if (snapshot.hasError) {
                print("Stream Error: ${snapshot.error}");
                return TextButton(
                    onPressed: retryLoad,
                    child: const Center(child: Text("뭔가 문제가 생겼습니다. 재시도하기")));
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  color: context.appColors.primaryColor,
                );
              } else {
                return CircularProgressIndicator(
                  color: context.appColors.primaryColor,
                );
              }
              // switch (snapshot.connectionState) {
              //   case ConnectionState.none:
              //     {
              //       return Text('none');
              //     }
              //   case ConnectionState.waiting:
              //   case ConnectionState.active:
              //     {
              //       return const Center(
              //         child: Text('잠시 기다려 주세요'),
              //       );
              //     }
              //   case ConnectionState.done:
              //     {
              //       List<Student> studentsList = snapshot.data!;
              //       return MasonryGridView.count(
              //           padding: const EdgeInsets.fromLTRB(
              //               16, appBarHeight + 16, 16, 60),
              //           crossAxisCount: 2,
              //           mainAxisSpacing: 16,
              //           crossAxisSpacing: 16,
              //           itemCount: studentsList.length,
              //           itemBuilder: (context, index) {
              //             final student = studentsList[index];
              //             return Tap(
              //                 onTap: () {
              //                   context.goNamed('student-profile',
              //                       extra: student,
              //                       pathParameters: {'id': student.user.id});
              //                 },
              //                 child: BuildStudentCard(student));
              //           });
              //     }
              // }
            },
          ),
          const HomeAppBar(),
        ],
      ),
    );
  }

  Stream<List<UserData>> getUserStream() async* {
    List<UserData> users = [];

    final snapshot = db
        .collection('users')
        .where('initialSetup', isEqualTo: true)
        .where('accountType', isEqualTo: false)
        .orderBy('onlineTime', descending: true)
        .snapshots();

    await for (final query in snapshot) {
      users = [];
      for (var doc in query.docs) {
        final user = UserData.fromJson(doc.data());
        print(user.name);
        users.add(user);
      }
      print('users data list: ${users.map((e) => e.name).toList()}');
      yield users;
    }
  }

  Stream<List<Student>> getStudentStream() async* {
    List<Student> students = [];
    final userStream = getUserStream();

    await for (final users in userStream) {
      students = [];
      for (final user in users) {
        final student = await db
            .collection('users')
            .doc(user.email)
            .collection('type')
            .doc('student')
            .get();

        final studentPF = Student.fromFirestore(user, student.data()!);
        print(studentPF.user.name);
        students.add(studentPF);
      }
      print(
          "student profiles list: ${students.map((e) => e.user.name).toList()}");
      yield students;
    }
  }
}
