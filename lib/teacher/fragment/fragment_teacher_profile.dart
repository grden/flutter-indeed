import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_profile_box.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:self_project/model/model_teacher.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/provider/provider_user.dart';
import 'package:self_project/student/widget/widget_teacher_card.dart';

class TeacherProfileFragment extends ConsumerStatefulWidget {
  const TeacherProfileFragment({super.key});

  @override
  ConsumerState<TeacherProfileFragment> createState() =>
      _MyProfileFragmentState();
}

class _MyProfileFragmentState extends ConsumerState<TeacherProfileFragment>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    UserCredential userCredential = ref.watch(userCredentialProvider)!;
    Stream<Teacher> teacherStream = getTeacherStream(userCredential: userCredential);
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
          stream: teacherStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Teacher teacher = snapshot.data!;
              return CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    _ProfileBox(teacher: teacher),
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
                                  Text('경력'),
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
                            buildInfoTab(context, teacher),
                            buildXPTab(context),
                            buildReviewTab(context)
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
                    teacherStream = getTeacherStream(userCredential: userCredential);
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

  Container buildReviewTab(BuildContext context) {
    return Container(
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
    );
  }

  Container buildXPTab(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: context.appColors.backgroundColor,
      child: Column(
        children: [
          const XPBox(subject: "수학", age: "고등학교 3학년", date: "2022.12 ~ 2023.09", period: "10개월", canEdit: true,),
          const Height(16),
          const XPBox(subject: "국어", age: "고등학교 1학년", date: "2022.12 ~ 2023.05", period: "6개월", canEdit: true,),
          const Height(16),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_circle_outline, color: context.appColors.primaryText,),
            label: Text('경력 추가', style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500, color: context.appColors.primaryText),),
          ),
        ],
      )
    );
  }

  Container buildInfoTab(BuildContext context, Teacher teacher) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: context.appColors.backgroundColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            InfoBox(
              title: '과목 및 시급',
              canEdit: true,
              child: Column(
                children: [
                  teacher.budget == null ? const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "아직 시급을 설정하지 않았습니다",
                        style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ) :
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '시간당 ${teacher.budget}만원',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ),
                  const Height(12),
                  SizedBox(
                    width: double.infinity,
                    height: teacher.subjects.length > 4 ? 92 : 44,
                    child: GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        teacher.subjects.length,
                        (e) => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.appColors.textFieldColor,
                              border:
                                  Border.all(color: context.appColors.lineColor)),
                          child: Center(
                            child: Text(
                              teacher.subjects[e].subjectString,
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
            const InfoBox(
              title: '소개',
              canEdit: true,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '현재 시립대학교 컴퓨터공학과 재학중입니다.\n\n학창시절 잊지 못한 첫사랑만큼, 열정적으로 학생을 가르치겠습니다.',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> _initTeacher(userCredential) async {
  //   final teacher = await getTeacher(userCredential: userCredential);
  //   _teacher = teacher;
  // }
  //
  // Future<void> _refreshTeacher(userCredential) async {
  //   final teacher = await getTeacher(userCredential: userCredential);
  //   setState(() {
  //     _teacher = teacher;
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

  Stream<Teacher> getTeacherStream(
      {required UserCredential userCredential}) async* {
    final UserCredential userCred = userCredential;
    final userStream = getUserStream(userCredential: userCred);

    await for (final user in userStream) {
      final teacherStream = db
          .collection('users')
          .doc(user.email)
          .collection('type')
          .doc('teacher')
          .snapshots();

      await for (final teacher in teacherStream) {
        final teacherPF = Teacher.fromFirestore(user, teacher.data()!);
        print(teacherPF.user.name);
        yield teacherPF;
      }
    }
  }
}

class _ProfileBox extends StatelessWidget {
  final Teacher teacher;

  const _ProfileBox({required this.teacher});

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
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: teacher.profileImagePath != null
                            ? Image(
                                image: NetworkImage(teacher.profileImagePath!),
                                fit: BoxFit.fill,
                              )
                            : const Image(
                                image: AssetImage(
                                    'assets/image/default_profile.png')),
                      ),
                    ),
                    const Height(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            teacher.displayName,
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
                              color: teacher.user.gender != Gender.male
                                  ? context.appColors.womanBadge
                                  : context.appColors.manBadge),
                          child: Center(
                            child: Text(
                              teacher.user.gender.genderString,
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
                          '${teacher.user.age}',
                          style: TextStyle(
                              color: context.appColors.secondaryText,
                              fontSize: 19,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const Height(8),
                    Flexible(
                      child: Text(
                        '${addString(teacher.univ, '대')} ${teacher.major ?? ''} ${addString(teacher.studentID, '학번')}',
                        style: TextStyle(
                          color: context.appColors.primaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    const Height(8),
                    Text(
                      teacher.user.locations.locationString,
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

// Future<Teacher> getTeacher({required UserCredential userCredential}) async {
//   final UserCredential userCred = userCredential;
//   final userDoc = await db
//       .collection('users')
//       .doc(userCred.user!.email!)
//       .get()
//       .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
//   final teacherDoc = await db
//       .collection('users')
//       .doc(userCred.user!.email!)
//       .collection('type')
//       .doc('teacher')
//       .get()
//       .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
//
//   final user = UserData.fromJson(userDoc);
//   final teacher = Teacher.fromFirestore(user, teacherDoc);
//   return teacher;
// }
