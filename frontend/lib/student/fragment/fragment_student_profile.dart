import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../common/widget/widget_profile_appbar.dart';
import '../../common/extension/extension_context.dart';
import '../../common/widget/widget_profile_box.dart';
import '../../common/widget/widget_line.dart';
import '../../common/widget/widget_sizedbox.dart';
import '../../model/model_student.dart';
import '../../model/model_user.dart';
import '../../provider/provider_user.dart';

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

  @override
  Widget build(BuildContext context) {
    UserCredential userCredential = ref.watch(userCredentialProvider)!;
    Stream<Student> studentStream =
        getStudentStream(userCredential: userCredential);
    return Column(children: [
      const ProfileAppBar(),
      Expanded(
        child: StreamBuilder(
          stream: studentStream,
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
                                labelColor: context.appColors.primaryColor,
                                unselectedLabelColor:
                                    context.appColors.secondaryText,
                                labelPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                indicatorColor: context.appColors.primaryColor,
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
                            buildInfoTab(context, student),
                            buildReviewTab(context, student),
                          ],
                        ),
                      ),
                    ),
                  ]);
            }
            if (snapshot.hasError) {
              print("Stream Error: ${snapshot.error}");
              return TextButton(
                child: const Center(child: Text("뭔가 문제가 생겼습니다. 재시도하기")),
                onPressed: () {
                  setState(() {
                    studentStream =
                        getStudentStream(userCredential: userCredential);
                  });
                },
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

  Container buildReviewTab(BuildContext context, Student student) {
    final userCred = ref.watch(userCredentialProvider)!;
    final reviewRef = db
        .collection('users')
        .doc(userCred.user?.email)
        .collection('type')
        .doc('student')
        .collection('reviews');

    return Container(
      padding: const EdgeInsets.all(16),
      color: context.appColors.backgroundColor,
      child: StreamBuilder(
        stream: reviewRef.snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                '아직 평가가 없습니다 \u{1f480} ',
                style: TextStyle(fontSize: 17),
              ));
            } else {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: docs.length,
                itemBuilder: (_, index) {
                  final review = docs[index].data();
                  return StudentReviewBox(
                    content: review['content'],
                    subjects: review['subjects'],
                    canEdit: true,
                    reviewer: review['reviewer'],
                    reply: review['reply'] ?? "",
                    student: student,
                    displayName: review['displayName'],
                  );
                },
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Container buildInfoTab(BuildContext context, Student student) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: context.appColors.backgroundColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            InfoBox(
              title: '과목',
              canEdit: true,
              accountType: student.user.accountType!,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: student.subjects.length > 4 ? 92 : 44,
                    child: GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        student.subjects.length,
                        (e) => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.appColors.textFieldColor,
                              border: Border.all(
                                  color: context.appColors.lineColor)),
                          child: Center(
                            child: Text(
                              student.subjects[e].subjectString,
                              style: const TextStyle(fontSize: 17),
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
              canEdit: true,
              accountType: student.user.accountType!,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  student.info,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

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
