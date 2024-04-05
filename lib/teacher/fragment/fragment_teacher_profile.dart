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
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  late final tabController = TabController(length: 3, vsync: this);
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
                                  labelColor: context.appColors.primaryColor,
                                  unselectedLabelColor:
                                      context.appColors.secondaryText,
                                  labelPadding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  indicatorColor:
                                      context.appColors.primaryColor,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
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
                              Container(
                                padding: const EdgeInsets.all(16),
                                color: context.appColors.backgroundColor,
                                child: Column(
                                  children: [
                                    InfoBox(
                                      title: '과목 및 시급',
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '시간당 ${_teacher.budget}만원',
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          const Height(12),
                                          SizedBox(
                                            width: double.infinity,
                                            height: _teacher.subjects.length > 4
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
                                                _teacher.subjects.length,
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
                                                          color: context
                                                              .appColors
                                                              .lineColor)),
                                                  child: Center(
                                                    child: Text(
                                                      _teacher.subjects[e]
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
                                    const InfoBox(
                                      title: '소개',
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '안녕하세요',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                color: Colors.amber,
                              ),
                              Container(
                                color: Colors.lime,
                              )
                            ],
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
                        fontSize: 15,
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
