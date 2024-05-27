import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:go_router/go_router.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../common/constant.dart';
import '../../common/extension/extension_context.dart';
import '../../common/widget/widget_contact_button.dart';
import '../../common/widget/widget_profile_box.dart';
import '../../common/widget/widget_line.dart';
import '../../common/widget/widget_sizedbox.dart';
import '../../model/model_student.dart';
import '../../model/model_user.dart';
import '../../provider/provider_user.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  final String id;
  final Student student;

  const StudentProfileScreen({
    super.key,
    required this.student,
    required this.id,
  });

  @override
  ConsumerState<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState extends ConsumerState<StudentProfileScreen>
    with SingleTickerProviderStateMixin {
  final db = FirebaseFirestore.instance;

  late final tabController = TabController(length: 2, vsync: this);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.appColors.backgroundColor,
        child: Column(children: [
          AppBar(
            backgroundColor: context.appColors.backgroundColor,
            scrolledUnderElevation: 0,
            toolbarHeight: appBarHeight,
          ),
          Expanded(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                _ProfileBox(
                  student: widget.student,
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
                        buildInfoTab(context),
                        buildReviewTab(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Container buildReviewTab(BuildContext context) {
    final reviewRef = db
        .collection('users')
        .doc(widget.student.user.email)
        .collection('type')
        .doc('student')
        .collection('reviews');
    final chatRef = db.collection('chat');
    final userCredential = ref.watch(userCredentialProvider);
    String docName =
        '${userCredential?.user?.email}-${widget.student.user.email}';

    return Container(
      padding: const EdgeInsets.all(16),
      color: context.appColors.backgroundColor,
      child: StreamBuilder(
        stream: reviewRef.snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return Column(
              children: [
                if (snapshot.data!.docs.isEmpty) ...[
                  const Center(
                    child: Text(
                      '아직 평가가 없습니다 \u{1f480} ',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  const Height(12),
                ],
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: docs.length,
                  itemBuilder: (_, index) {
                    final review = docs[index].data();
                    return StudentReviewBox(
                      content: review['content'],
                      subjects: review['subjects'],
                      canEdit: false,
                      reviewer: review['reviewer'],
                      reply: review['reply'] ?? "",
                      student: widget.student,
                      displayName: review['displayName'],
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: () {
                    chatRef.doc(docName).get().then((documentSnapshot) {
                      final doc = documentSnapshot.data();
                      if (doc?['studentOK'] && doc?['teacherOK']) {
                        // GoRouter.of(context)
                        //     .pushNamed('new-review', extra: widget.teacher);
                      } else {
                        print('not matched');
                        Dialogs.materialDialog(
                            context: context,
                            msg: '과외가 성사된 학생의 평가만\n작성할 수 있습니다.',
                            msgAlign: TextAlign.center,
                            msgStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.primaryText),
                            color: Colors.white,
                            dialogShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            actions: [
                              IconsOutlineButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                text: '확인',
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: context.appColors.inverseText),
                                color: context.appColors.primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                padding: const EdgeInsets.all(12),
                              )
                            ]);
                      }
                    });
                  },
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: context.appColors.primaryText,
                  ),
                  label: Text(
                    '평가 작성하기',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: context.appColors.primaryText),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Container buildInfoTab(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: context.appColors.backgroundColor,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            InfoBox(
              title: '과목',
              canEdit: false,
              child: SizedBox(
                height: widget.student.subjects.length > 4 ? 92 : 44,
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                    widget.student.subjects.length,
                    (e) => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.appColors.textFieldColor,
                          border:
                              Border.all(color: context.appColors.lineColor)),
                      child: Center(
                        child: Text(
                          widget.student.subjects[e].subjectString,
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Height(16),
            InfoBox(
              title: '소개',
              canEdit: false,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.student.info,
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
}

class _ProfileBox extends ConsumerWidget {
  final Student student;

  const _ProfileBox({
    required this.student,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    const Height(16),
                    ContactButton(
                        textColor: context.appColors.inverseText,
                        backgroundColor: context.appColors.primaryColor,
                        onTap: () {
                          final chatRef = db.collection('chat');
                          final userCredential =
                              ref.watch(userCredentialProvider);
                          String docName =
                              '${userCredential?.user?.email}-${student.user.email}';

                          chatRef.doc(docName).get().then((documentSnapshot) {
                            if (!documentSnapshot.exists) {
                              chatRef.doc(docName).set({
                                'members': [
                                  userCredential?.user?.email,
                                  student.user.email,
                                ],
                                'studentOK': false,
                                'teacherOK': false,
                                'lastMsg': 'start a conversation',
                              });
                            }
                          });

                          context.pushNamed('chat', pathParameters: {
                            'email': student.user.email
                          }, extra: {
                            'name': student.user.name,
                            'docName': docName,
                            'accountType': true,
                          });
                        })
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
