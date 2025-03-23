import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/widget_tap.dart';
import 'widget_sender_message.dart';
import '../../common/extension/extension_context.dart';
import '../../common/widget/widget_sizedbox.dart';
import '../../model/model_chat.dart';
import '../../model/model_teacher.dart';
import '../../model/model_user.dart';

class StudentChatBoxWidget extends StatelessWidget {
  final ChatData chat;
  final String userEmail;
  const StudentChatBoxWidget(
      {super.key, required this.chat, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    Stream<Teacher> teacherStream = getTeacherStream(email: chat.members[0]);
    return Container(
      color: context.appColors.backgroundColor,
      // decoration: BoxDecoration(
      //     border:
      //         Border(bottom: BorderSide(color: context.appColors.lineColor))),
      padding: const EdgeInsets.all(12),
      child: StreamBuilder(
          stream: teacherStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Teacher teacher = snapshot.data!;
              return Tap(
                onTap: () {
                  String docName = '${teacher.user.email}-$userEmail';
                  context.pushNamed('chat', pathParameters: {
                    'email': teacher.user.email
                  }, extra: {
                    'name': teacher.displayName,
                    'profileImage': teacher.profileImagePath,
                    'docName': docName,
                    'accountType': false,
                  });
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: teacher.profileImagePath != null
                            ? Image(
                                image: NetworkImage(teacher.profileImagePath!),
                                fit: BoxFit.cover,
                              )
                            : const Image(
                                image: AssetImage(
                                    'assets/image/default_profile.png')),
                      ),
                    ),
                    const Width(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacher.displayName,
                          style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                              color: context.appColors.primaryText),
                        ),
                        Text(
                          chat.lastMsg,
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: context.appColors.secondaryText),
                        )
                      ],
                    ),
                    const Spacer(),
                    Text(
                      timeAgoCustom(chat.lastTime),
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: context.appColors.secondaryText),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              print("Stream Error: ${snapshot.error}");
              return CircularProgressIndicator(
                color: context.appColors.primaryColor,
              );
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator(
                color: context.appColors.primaryColor,
              );
            } else {
              return CircularProgressIndicator(
                color: context.appColors.primaryColor,
              );
            }
          }),
    );
  }
}

Stream<UserData> getUserStream({required String email}) async* {
  final db = FirebaseFirestore.instance;
  final snapshot = db.collection('users').doc(email).snapshots();

  await for (final doc in snapshot) {
    final user = UserData.fromJson(doc.data()!);
    yield user;
  }
}

Stream<Teacher> getTeacherStream({required String email}) async* {
  final db = FirebaseFirestore.instance;
  final userStream = getUserStream(email: email);

  await for (final user in userStream) {
    final teacherStream = db
        .collection('users')
        .doc(user.email)
        .collection('type')
        .doc('teacher')
        .snapshots();

    await for (final teacher in teacherStream) {
      final teacherPF = Teacher.fromFirestore(user, teacher.data()!);
      yield teacherPF;
    }
  }
}
