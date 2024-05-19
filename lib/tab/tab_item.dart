import 'package:flutter/cupertino.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/chat/fragment_chat.dart';
import 'package:self_project/student/fragment/fragment_student_profile.dart';
import 'package:self_project/teacher/fragment/fragment_student_home.dart';
import 'package:self_project/teacher/fragment/fragment_teacher_profile.dart';
import 'package:self_project/student/fragment/fragment_teacher_home.dart';

enum TabItem {
  studentHome(CupertinoIcons.compass_fill, '선생님 찾기', TeacherHomeFragment(),
      inActiveIcon: CupertinoIcons.compass),
  teacherHome(CupertinoIcons.compass_fill, '학생 찾기', StudentHomeFragment(),
      inActiveIcon: CupertinoIcons.compass),
  chat(CupertinoIcons.chat_bubble_2_fill, '채팅', ChatFragment(),
      inActiveIcon: CupertinoIcons.chat_bubble_2),
  teacherProfile(CupertinoIcons.person_fill, '내 정보', TeacherProfileFragment(),
      inActiveIcon: CupertinoIcons.person),
  studentProfile(CupertinoIcons.person_fill, '내 정보', StudentProfileFragment(),
      inActiveIcon: CupertinoIcons.person);

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage,
      {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context,
      {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color: isActivated
              ? context.appColors.primaryColor
              : context.appColors.iconButtonInactivate,
        ),
        label: tabName);
  }
}
