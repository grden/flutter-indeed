import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
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
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late final tabController = TabController(length: 2, vsync: this);
  int currentIndex = 0;

  late final UserCredential? userCred;
  late Student _student;
  late Future<void> _initStudentData;

  @override
  void initState() {
    super.initState();
    userCred = ref.read(userCredentialProvider);
    _initStudentData = _initStudent(userCred);
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
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => _refreshStudent(userCred),
              //edgeOffset: appBarHeight,
              color: context.appColors.primaryColor,
              backgroundColor: context.appColors.cardColor,
              child: FutureBuilder(
                future: _initStudentData,
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
                          _ProfileBox(student: _student),
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

  Future<void> _initStudent(userCredential) async {
    final student = await getStudent(userCredential: userCredential);
    _student = student;
  }

  Future<void> _refreshStudent(userCredential) async {
    final student = await getStudent(userCredential: userCredential);
    setState(() {
      _student = student;
    });
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

Future<Student> getStudent({required UserCredential userCredential}) async {
  final UserCredential userCred = userCredential;
  final userDoc = await db
      .collection('users')
      .doc(userCred.user!.email!)
      .get()
      .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);
  final studentDoc = await db
      .collection('users')
      .doc(userCred.user!.email!)
      .collection('type')
      .doc('student')
      .get()
      .then((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>);

  final user = UserData.fromJson(userDoc);
  final student = Student.fromFirestore(user, studentDoc);
  return student;
}

Stream<Student> getStudentStream({required UserCredential userCredential}) {
  final UserCredential userCred = userCredential;

  final userDoc = db.collection('users').doc(userCred.user!.email!);
  final studentDoc = db
      .collection('users')
      .doc(userCred.user!.email!)
      .collection('type')
      .doc('student');

  return studentDoc.snapshots().asyncMap((studentSnapshot) async {
    final studentData = studentSnapshot.data();

    final userSnapshot = await userDoc.get();
    final userData = userSnapshot.data();

    final user = UserData.fromJson(userData!);
    final student = Student.fromFirestore(user, studentData!);
    return student;
  });
}
