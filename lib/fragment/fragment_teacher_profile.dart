import 'package:flutter/material.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_contact_button.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:self_project/object/object_extended_teacher_profile.dart';
import 'package:self_project/object/object_profile.dart';
import 'package:self_project/object/object_teacher_profile.dart';
import 'package:self_project/widget/widget_teacher_card.dart';

class TeacherProfileFragment extends StatefulWidget {
  final ExtendedTeacherProfile teacher;

  const TeacherProfileFragment(
    final String id, {
    super.key,
    required this.teacher,
  });

  @override
  State<TeacherProfileFragment> createState() => _TeacherProfileFragmentState();
}

class _TeacherProfileFragmentState extends State<TeacherProfileFragment>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  int currentIndex = 0;

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
            child: CustomScrollView(
              //physics: const ClampingScrollPhysics(),
              slivers: [
                _ProfileBox(
                  extendedTeacher: widget.teacher,
                ),
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
                              Text('경력'),
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
              ],
            ),
          ),
        ]);
  }
}

class _ProfileBox extends StatelessWidget {
  final ExtendedTeacherProfile extendedTeacher;

  const _ProfileBox({
    super.key,
    required this.extendedTeacher,
  });

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
                        child: Image(
                          image: AssetImage(extendedTeacher.profileImagePath ??
                              'assets/image/default_profile.png'),
                        ),
                      ),
                    ),
                    const Height(16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            extendedTeacher.nickname,
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
                              color:
                                  extendedTeacher.profile.gender != Gender.male
                                      ? context.appColors.womanBadge
                                      : context.appColors.manBadge),
                          child: Center(
                            child: Text(
                              extendedTeacher.profile.gender.genderString,
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
                          '${extendedTeacher.profile.age}',
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
                        '${addString(extendedTeacher.univ, '대')} ${extendedTeacher.major ?? ''} ${addString(extendedTeacher.studentID, '학번')}',
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
                    const Height(16),
                    ContactButton(
                        textColor: context.appColors.inverseText,
                        backgroundColor:
                            context.appColors.primaryColor,
                        onTap: () {})
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
