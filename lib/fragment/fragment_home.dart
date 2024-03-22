import 'package:flutter/material.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/dummy/dummy_teacher_profile.dart';
import 'package:self_project/fragment/fragment_teacher_profile.dart';
import 'package:self_project/widget/widget_home_appbar.dart';
import 'package:self_project/common/widget/widget_tap.dart';
import 'package:self_project/widget/widget_teacher_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  // initstate로 teacherprofiles 최초 받기/ refresh때마다 다시 받기

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.appColors.backgroundColor,
      child: Stack(
        children: [
          RefreshIndicator(
            edgeOffset: appBarHeight,
            color: context.appColors.primaryColor,
            backgroundColor: context.appColors.cardColor,
            onRefresh: () async {
              await Future.delayed(500000.microseconds, () => {});
            },
            child: MasonryGridView.count(
              padding: const EdgeInsets.fromLTRB(16, appBarHeight + 16, 16, 60),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: teacherProfiles.length,
              itemBuilder: (context, index) => Tap(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherProfileFragment(
                            teacherProfiles[index].profile.id, extendedTeacher: teacherProfiles[index],
                          ),
                        ));
                  },
                  child: BuildTeacherCard(teacherProfiles, index)),
            ),
          ),
          const HomeAppBar(),
        ],
      ),
    );
  }
}
