import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../common/constant.dart';
import '../../common/extension/extension_context.dart';
import '../../common/widget/widget_contact_button.dart';
import '../../common/widget/widget_profile_box.dart';
import '../../common/widget/widget_line.dart';
import '../../common/widget/widget_sizedbox.dart';
import '../../model/model_teacher.dart';
import '../../model/model_user.dart';
import '../../provider/provider_user.dart';

import '../widget/widget_teacher_card.dart';

class TeacherProfileScreen extends ConsumerStatefulWidget {
  final String id;
  final Teacher teacher;

  const TeacherProfileScreen({
    super.key,
    required this.teacher,
    required this.id,
  });

  @override
  ConsumerState<TeacherProfileScreen> createState() =>
      _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends ConsumerState<TeacherProfileScreen>
    with SingleTickerProviderStateMixin {
  final db = FirebaseFirestore.instance;
  // List<Map<String, dynamic>> _reviewsList = [];
  // late Future<void> _initReviewsData;

  late final tabController = TabController(length: 3, vsync: this);
  int currentIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _initReviewsData = _initReviews();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.appColors.backgroundColor,
        child: Column(
            //appBar: const ProfileAppBar(),
            children: [
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
                      teacher: widget.teacher,
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
                            buildInfoTab(context),
                            buildXPTab(context),
                            buildReviewTab(context)
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

  // Future<void> _initReviews() async {
  //   final reviews = await getReviews();
  //   _reviewsList = reviews;
  // }

  // Future<List<Map<String, dynamic>>> getReviews() async {
  //   List<Map<String, dynamic>> reviews = [];
  //   final reviewRef = db
  //       .collection('users')
  //       .doc(widget.teacher.user.email)
  //       .collection('type')
  //       .doc('teacher')
  //       .collection('reviews');

  //   var querySnapshot =
  //       await reviewRef.orderBy('onlineTime', descending: true).get();

  //   for (var queryDocumentSnapshot in querySnapshot.docs) {
  //     Map<String, dynamic> data = queryDocumentSnapshot.data();
  //     reviews.add(data);
  //   }
  //   return reviews;
  // }

  Container buildReviewTab(BuildContext context) {
    final reviewRef = db
        .collection('users')
        .doc(widget.teacher.user.email)
        .collection('type')
        .doc('teacher')
        .collection('reviews');
    final chatRef = db.collection('chat');
    final userCredential = ref.watch(userCredentialProvider);
    String docName =
        '${widget.teacher.user.email}-${userCredential?.user?.email}';

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
                    return TeacherReviewBox(
                      content: review['content'],
                      subjects: review['subjects'],
                      canEdit: false,
                      gender: review['gender'],
                      age: review['age'],
                      teacher: widget.teacher,
                      reviewer: review['reviewer'],
                      reply: review['reply'] ?? "",
                    );
                  },
                ),
                TextButton.icon(
                  onPressed: () {
                    chatRef.doc(docName).get().then((documentSnapshot) {
                      final doc = documentSnapshot.data();
                      if (doc?['studentOK'] && doc?['teacherOK']) {
                        GoRouter.of(context)
                            .pushNamed('new-review', extra: widget.teacher);
                      } else {
                        print('not matched');
                        Dialogs.materialDialog(
                            context: context,
                            msg: '과외가 성사된 선생님의 평가만\n작성할 수 있습니다.',
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
      // child: Column(
      //   children: [
      //     Expanded(
      //       child: ListView.builder(
      //           //shrinkWrap: true,
      //           padding: EdgeInsets.zero,
      //           physics: const NeverScrollableScrollPhysics(),
      //           itemCount: _reviewsList.length,
      //           itemBuilder: (context, index) {
      //             final review = _reviewsList[index];
      //             return TeacherReviewBox(
      //               content: review['content'],
      //               subjects: review['subjects'],
      //               canEdit: false,
      //               gender: review['gender'],
      //               age: review['age'],
      //               teacher: widget.teacher,
      //               reviewer: review['reviewer'],
      //               reply: review['reply'] ?? "",
      //             );
      //           }),
      //     ),
      //     // temporary way to add reviews
      //     TextButton.icon(
      //       onPressed: () {
      //         GoRouter.of(context)
      //             .pushNamed('new-review', extra: widget.teacher);
      //       },
      //       icon: Icon(
      //         Icons.add_circle_outline,
      //         color: context.appColors.primaryText,
      //       ),
      //       label: Text(
      //         '평가 작성하기',
      //         style: TextStyle(
      //             fontSize: 19,
      //             fontWeight: FontWeight.w500,
      //             color: context.appColors.primaryText),
      //       ),
      //     ),
      //   ],
      // ),
      // child: FutureBuilder<Object>(
      //     future: getReviews(),
      //     builder: (context, snapshot) {
      //       switch (snapshot.connectionState) {
      //         case ConnectionState.none:
      //         case ConnectionState.waiting:
      //         case ConnectionState.active:
      //           {
      //             return Center(
      //                 child: CircularProgressIndicator(
      //               color: context.appColors.primaryColor,
      //             ));
      //           }
      //         case ConnectionState.done:
      //           {
      //             return Column(
      //               children: [
      //                 ListView.builder(
      //                   shrinkWrap: true,
      //                   itemBuilder: (BuildContext context, int index) {
      //                     return null;
      //                   },
      //                 ),
      //                 // temporary way to add reviews
      //                 TextButton.icon(
      //                   onPressed: () {
      //                     GoRouter.of(context)
      //                         .pushNamed('new-review', extra: widget.teacher);
      //                   },
      //                   icon: Icon(
      //                     Icons.add_circle_outline,
      //                     color: context.appColors.primaryText,
      //                   ),
      //                   label: Text(
      //                     '평가 작성하기',
      //                     style: TextStyle(
      //                         fontSize: 19,
      //                         fontWeight: FontWeight.w500,
      //                         color: context.appColors.primaryText),
      //                   ),
      //                 ),
      //               ],
      //             );
      //           }
      //       }
      //     }),
    );
  }

  Container buildXPTab(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        color: context.appColors.backgroundColor,
        child: const Column(
          children: [
            XPBox(
              subject: "수학",
              age: "고등학교 3학년",
              date: "2022.12 ~ 2023.09",
              period: "10개월",
              canEdit: false,
            ),
            Height(16),
            XPBox(
              subject: "국어",
              age: "고등학교 1학년",
              date: "2022.12 ~ 2023.05",
              period: "6개월",
              canEdit: false,
            ),
          ],
        ));
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
              title: '과목 및 시급',
              canEdit: false,
              child: Column(
                children: [
                  widget.teacher.budget == null
                      ? const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "아직 시급을 설정하지 않았습니다",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '시간당 ${widget.teacher.budget}만원',
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                        ),
                  const Height(12),
                  SizedBox(
                    width: double.infinity,
                    height: widget.teacher.subjects.length > 4 ? 92 : 44,
                    child: GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(
                        widget.teacher.subjects.length,
                        (e) => Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: context.appColors.textFieldColor,
                              border: Border.all(
                                  color: context.appColors.lineColor)),
                          child: Center(
                            child: Text(
                              widget.teacher.subjects[e].subjectString,
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
              canEdit: false,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '안녕하세요',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
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
  final Teacher teacher;

  const _ProfileBox({
    required this.teacher,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = FirebaseFirestore.instance;

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
                    const Height(16),
                    ContactButton(
                        textColor: context.appColors.inverseText,
                        backgroundColor: context.appColors.primaryColor,
                        onTap: () {
                          final chatRef = db.collection('chat');
                          final userCredential =
                              ref.watch(userCredentialProvider);
                          String docName =
                              '${teacher.user.email}-${userCredential?.user?.email}';

                          chatRef.doc(docName).get().then((documentSnapshot) {
                            if (!documentSnapshot.exists) {
                              chatRef.doc(docName).set({
                                'members': [
                                  teacher.user.email,
                                  userCredential?.user?.email
                                ],
                                'studentOK': false,
                                'teacherOK': false,
                                'lastMsg': 'start a conversation',
                                'lastTime': Timestamp.fromDate(DateTime.now())
                              });
                            }
                          });

                          context.pushNamed('chat', pathParameters: {
                            'email': teacher.user.email
                          }, extra: {
                            'name': teacher.displayName,
                            'profileImage': teacher.profileImagePath,
                            'docName': docName,
                            'accountType': false,
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
