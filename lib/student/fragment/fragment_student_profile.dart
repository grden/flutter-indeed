import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:self_project/model/model_teacher.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/provider/provider_user.dart';
import 'package:self_project/student/widget/widget_teacher_card.dart';

class StudentProfileFragment extends ConsumerStatefulWidget {
  const StudentProfileFragment({super.key});

  @override
  ConsumerState<StudentProfileFragment> createState() => _MyProfileFragmentState();
}

class _MyProfileFragmentState extends ConsumerState<StudentProfileFragment>
    with SingleTickerProviderStateMixin {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late final tabController = TabController(length: 2, vsync: this);
  int currentIndex = 0;

  late final UserCredential? userCred;
  late Teacher _teacher;
  late Future<void> _initTeacherData;

  @override
  void initState() {
    super.initState();
    userCred = ref.read(userCredentialProvider);
    _initTeacherData = _initTeacher(userCred);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //appBar: const ProfileAppBar(),
        children: [
          AppBar(
            backgroundColor: context.appColors.backgroundColor,
            scrolledUnderElevation: 0,
            toolbarHeight: appBarHeight,
          ),
          Expanded(
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => _refreshTeacher(userCred),
              //edgeOffset: appBarHeight,
              color: context.appColors.primaryColor,
              backgroundColor: context.appColors.cardColor,
              child: FutureBuilder(
                future: _initTeacherData,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      {
                        return Center(
                          child: CircularProgressIndicator(
                            color: context.appColors.primaryColor,
                            backgroundColor: context.appColors.cardColor,
                          ),
                        );
                      }
                    case ConnectionState.done:
                      {
                        return CustomScrollView(slivers: [
                          _ProfileBox(teacher: _teacher),
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
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                      labelColor: context.appColors.primaryText,
                                      unselectedLabelColor:
                                      context.appColors.secondaryText,
                                      labelPadding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      indicatorColor:
                                      context.appColors.iconButton,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      tabs: const [
                                        Text('소개'),
                                        Text('평가'),
                                      ],
                                    ),
                                    const Line(),
                                  ]),
                            ),
                            sliver: const SliverToBoxAdapter(
                              child: Column(
                                children: [Placeholder(), Placeholder()],
                              ),
                            ),
                          ),
                        ]);
                      }
                  }
                },
              ),
            ),
          ),
        ]);
  }

  Future<void> _initTeacher(userCredential) async {
    final teacher = await getTeacher(userCredential: userCredential);
    _teacher = teacher;
  }

  Future<void> _refreshTeacher(userCredential) async {
    final teacher = await getTeacher(userCredential: userCredential);
    setState(() {
      _teacher = teacher;
    });
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
                          color: context.appColors.secondaryText,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                    //const Height(16),
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

// final userStreamProvider = StreamProvider((ref) {
//   final userCred = ref.watch(userCredentialProvider);
//   return db.collection('users').doc(userCred!.user!.email).snapshots();
// });
//
// final teacherStreamProvider = StreamProvider((ref) {
//   final userCred = ref.watch(userCredentialProvider);
//   return db
//       .collection('users')
//       .doc(userCred!.user!.email)
//       .collection('type')
//       .doc('teacher')
//       .snapshots();
// });
//
// final teacherPfStreamProvider = StreamProvider((ref) async* {
//   final userSnapshot = ref.watch(userStreamProvider);
//   final teacherSnapshot = ref.watch(teacherStreamProvider);
//   final user = UserData.fromJson(userSnapshot.value!.data()!);
//   final teacherPf = Teacher.fromFirestore(user, teacherSnapshot.value!.data()!);
//   yield teacherPf;
// });

Future<Teacher> getTeacher({required UserCredential userCredential}) async {
  final UserCredential userCred = userCredential;
  final userDoc = await db
      .collection('users')
      .doc(userCred.user!.email!)
      .get()
      .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
  final teacherDoc = await db
      .collection('users')
      .doc(userCred.user!.email!)
      .collection('type')
      .doc('teacher')
      .get()
      .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);

  final user = UserData.fromJson(userDoc);
  final teacher = Teacher.fromFirestore(user, teacherDoc);
  return teacher;
}

Stream<Teacher> getTeacherStream({required UserCredential userCredential}) {
  final UserCredential userCred = userCredential;

  final userDoc = db.collection('users').doc(userCred.user!.email!);
  final teacherDoc = db
      .collection('users')
      .doc(userCred.user!.email!)
      .collection('type')
      .doc('teacher');

  return teacherDoc.snapshots().asyncMap((teacherSnapshot) async {
    final teacherData = teacherSnapshot.data();

    final userSnapshot = await userDoc.get();
    final userData = userSnapshot.data();

    final user = UserData.fromJson(userData!);
    final teacher = Teacher.fromFirestore(
        user, teacherData!); // 'user1' is a member object in user2
    return teacher;
  });
}
