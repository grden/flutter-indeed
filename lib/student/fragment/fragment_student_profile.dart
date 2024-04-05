import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_info_box.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:self_project/model/model_student.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/provider/provider_user.dart';

class StudentProfileFragment extends ConsumerStatefulWidget {
  const StudentProfileFragment({super.key});

  @override
  ConsumerState<StudentProfileFragment> createState() =>
      _MyProfileFragmentState();
}

class _MyProfileFragmentState extends ConsumerState<StudentProfileFragment>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);
  int currentIndex = 0;

  // late final UserCredential? userCred;
  // late Student _student;
  // late Future<void> _initStudentData;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   userCred = ref.read(userCredentialProvider);
  //   _initStudentData = _initStudent(userCred);
  // }

  @override
  Widget build(BuildContext context) {
    UserCredential userCredential = ref.watch(userCredentialProvider)!;

    return Column(children: [
      AppBar(
        backgroundColor: context.appColors.backgroundColor,
        scrolledUnderElevation: 0,
        toolbarHeight: appBarHeight,
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.settings_outlined,
              size: 28,
              color: context.appColors.iconButton,
            ),
          ),
          const Width(16),
        ],
      ),
      Expanded(
        child: StreamBuilder(
          stream: getStudentStream(userCredential: userCredential),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Student student = snapshot.data!;
              return CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    _ProfileBox(student: student),
                    SliverStickyHeader(
                      header: Container(
                        color: context.appColors.backgroundColor,
                        height: 60,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TabBar(
                                onTap: (index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                controller: tabController,
                                labelStyle: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500),
                                labelColor: context.appColors.primaryText,
                                unselectedLabelColor:
                                    context.appColors.secondaryText,
                                labelPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                indicatorColor: context.appColors.iconButton,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                tabs: const [
                                  Text('소개'),
                                  Text('평가'),
                                ],
                              ),
                              const Line(),
                            ]),
                      ),
                      sliver: SliverFillRemaining(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              color: context.appColors.backgroundColor,
                              child: Column(
                                children: [
                                  InfoBox(
                                    title: '과목',
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          height: student.subjects.length > 4
                                              ? 100
                                              : 50,
                                          child: GridView.count(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                            childAspectRatio: 2,
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            children: List.generate(
                                              student.subjects.length,
                                                  (e) => Container(
                                                padding:
                                                const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        8),
                                                    color: context.appColors
                                                        .textFieldColor,
                                                    border: Border.all(
                                                        color: context.appColors
                                                            .lineColor)),
                                                child: Center(
                                                  child: Text(
                                                    student.subjects[e]
                                                        .subjectString,
                                                    style: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Height(16),
                                  InfoBox(
                                    title: '소개',
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        student.info,
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              color: context.appColors.backgroundColor,
                              child: const Center(
                                child: Text(
                                  '아직 평가가 없습니다',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return CircularProgressIndicator(
                color: context.appColors.primaryColor,
              );
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
          },
        ),
      ),
    ]);
  }

  // Future<void> _initStudent(userCredential) async {
  //   final student = await getStudent(userCredential: userCredential);
  //   _student = student;
  // }
  //
  // Future<void> _refreshStudent(userCredential) async {
  //   final student = await getStudent(userCredential: userCredential);
  //   setState(() {
  //     _student = student;
  //   });
  // }

  Stream<UserData> getUserStream(
      {required UserCredential userCredential}) async* {
    final UserCredential userCred = userCredential;

    final snapshot =
        db.collection('users').doc(userCred.user!.email!).snapshots();

    await for (final doc in snapshot) {
      final user = UserData.fromJson(doc.data()!);
      yield user;
    }
  }

  Stream<Student> getStudentStream(
      {required UserCredential userCredential}) async* {
    final UserCredential userCred = userCredential;
    final userStream = getUserStream(userCredential: userCred);

    await for (final user in userStream) {
      final studentStream = db
          .collection('users')
          .doc(user.email)
          .collection('type')
          .doc('student')
          .snapshots();

      await for (final student in studentStream) {
        final studentPF = Student.fromFirestore(user, student.data()!);
        print(studentPF.user.name);
        yield studentPF;
      }
    }
  }
}

class _ProfileBox extends StatelessWidget {
  final Student student;

  const _ProfileBox({required this.student});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          IntrinsicHeight(
            //delete this widget if possible
            child: Container(
              color: context.appColors.backgroundColor,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            student.user.name,
                            style: TextStyle(
                                color: context.appColors.primaryText,
                                fontSize: 19,
                                fontWeight: FontWeight.w700),
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                          ),
                        ),
                        const Width(8),
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: student.user.gender != Gender.male
                                  ? context.appColors.womanBadge
                                  : context.appColors.manBadge),
                          child: Center(
                            child: Text(
                              student.user.gender.genderString,
                              style: TextStyle(
                                color: context.appColors.cardColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        const Width(4),
                        Text(
                          '${student.user.age}',
                          style: TextStyle(
                              color: context.appColors.secondaryText,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Height(8),
                    Text(
                      student.user.locations.locationString,
                      style: TextStyle(
                        color: context.appColors.secondaryText,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Future<Student> getStudent({required UserCredential userCredential}) async {
//   final UserCredential userCred = userCredential;
//   final userDoc = await db
//       .collection('users')
//       .doc(userCred.user!.email!)
//       .get()
//       .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
//   final studentDoc = await db
//       .collection('users')
//       .doc(userCred.user!.email!)
//       .collection('type')
//       .doc('student')
//       .get()
//       .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
//
//   final user = UserData.fromJson(userDoc);
//   final student = Student.fromFirestore(user, studentDoc);
//   return student;
// }
//
// Stream<Student> getStudentStream({required UserCredential userCredential}) {
//   final UserCredential userCred = userCredential;
//
//   final userDoc = db.collection('users').doc(userCred.user!.email!);
//   final studentDoc = db
//       .collection('users')
//       .doc(userCred.user!.email!)
//       .collection('type')
//       .doc('student');
//
//   return studentDoc.snapshots().asyncMap((studentSnapshot) async {
//     final studentData = studentSnapshot.data();
//
//     final userSnapshot = await userDoc.get();
//     final userData = userSnapshot.data();
//
//     final user = UserData.fromJson(userData!);
//     final student = Student.fromFirestore(user, studentData!);
//     return student;
//   });
// }
