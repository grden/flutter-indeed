import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/model/model_teacher.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/common/widget/widget_home_appbar.dart';
import 'package:self_project/common/widget/widget_tap.dart';
import 'package:self_project/student/widget/widget_teacher_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TeacherHomeFragment extends StatefulWidget {
  const TeacherHomeFragment({super.key});

  @override
  State<TeacherHomeFragment> createState() => _TeacherHomeFragmentState();
}

class _TeacherHomeFragmentState extends State<TeacherHomeFragment> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  List<Teacher> _teachersList = [];
  late Future<void> _initTeachersData;

  // initstate로 teacherprofiles 최초 받기/ refresh때마다 다시 받기
  @override
  void initState() {
    super.initState();
    _initTeachersData = _initTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.backgroundColor,
      child: Stack(
        children: [
          RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _refreshTeachers,
            edgeOffset: appBarHeight,
            color: context.appColors.primaryColor,
            backgroundColor: context.appColors.cardColor,
            child: FutureBuilder(
              future: _initTeachersData,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    {
                      return Center(
                          child: CircularProgressIndicator(
                        color: context.appColors.primaryColor,
                      ));
                    }
                  case ConnectionState.done:
                    {
                      return MasonryGridView.count(
                          padding: const EdgeInsets.fromLTRB(
                              16, appBarHeight + 16, 16, 60),
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          itemCount: _teachersList.length,
                          itemBuilder: (context, index) {
                            final teacher = _teachersList[index];
                            return Tap(
                                onTap: () {
                                  context.goNamed('teacher-profile',
                                      extra: teacher,
                                      pathParameters: {'id': teacher.user.id});
                                },
                                child: BuildTeacherCard(teacher));
                          });
                    }
                }
              },
            ),
          ),
          const HomeAppBar(),
        ],
      ),
    );
  }

  Future<void> _initTeachers() async {
    final teacher = await fetchTeacherProfiles();
    _teachersList = teacher;
  }

  Future<void> _refreshTeachers() async {
    final teacher = await fetchTeacherProfiles();
    setState(() {
      _teachersList = teacher;
    });
  }
}

Future<List<Teacher>> fetchTeacherProfiles() async {
  final db = FirebaseFirestore.instance;
  final response = await db
      .collection('users')
      .where('initialSetup', isEqualTo: true)
      .where('accountType', isEqualTo: true)
      .orderBy('onlineTime', descending: true)
      .get();
  List<Teacher> teacherProfiles = [];
  for (var doc in response.docs) {
    final user = UserData.fromJson(doc.data());
    //final realUser = user.copyWith(id: doc.id);
    final teacher = await db
        .collection('users')
        .doc(user.email)
        .collection('type')
        .doc('teacher')
        .get();
    final teacherPf = Teacher.fromFirestore(user, teacher.data()!);
    teacherProfiles.add(teacherPf);
  }
  return teacherProfiles;
}
