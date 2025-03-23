import 'package:flutter/cupertino.dart';

import '../chat/fragment_teacher_chat.dart';
import '../common/extension/extension_context.dart';
import '../chat/fragment_student_chat.dart';
import '../student/fragment/fragment_student_profile.dart';
import '../teacher/fragment/fragment_student_home.dart';
import '../teacher/fragment/fragment_teacher_profile.dart';
import '../student/fragment/fragment_teacher_home.dart';

enum TabItem {
  studentHome(CupertinoIcons.compass_fill, '선생님 찾기', TeacherHomeFragment(),
      inActiveIcon: CupertinoIcons.compass),
  teacherHome(CupertinoIcons.compass_fill, '학생 찾기', StudentHomeFragment(),
      inActiveIcon: CupertinoIcons.compass),
  studentChat(CupertinoIcons.chat_bubble_2_fill, '채팅', StudentChatFragment(),
      inActiveIcon: CupertinoIcons.chat_bubble_2),
  teacherChat(CupertinoIcons.chat_bubble_2_fill, '채팅', TeacherChatFragment(),
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
