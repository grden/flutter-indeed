import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/model/model_student.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/teacher/widget/widget_student_card.dart';
import 'package:self_project/widget/widget_home_appbar.dart';
import 'package:self_project/common/widget/widget_tap.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StudentHomeFragment extends ConsumerStatefulWidget {
  const StudentHomeFragment({super.key});

  @override
  ConsumerState<StudentHomeFragment> createState() => _StudentHomeFragmentState();
}

class _StudentHomeFragmentState extends ConsumerState<StudentHomeFragment> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.backgroundColor,
      child: Stack(
        children: [
          StreamBuilder(
            stream: getStudentStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Student> studentsList = snapshot.data!;
                if (studentsList.isEmpty) {
                  return Text('empty!');
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
                print(snapshot.error);
                return Center(child: Text('Error: ${snapshot.error}'));
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
      print("student profiles list: ${students.map((e) => e.user.name).toList()}");
      yield students;
    }
  }
}