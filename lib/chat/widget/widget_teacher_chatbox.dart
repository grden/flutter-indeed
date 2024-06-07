import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common/widget/widget_tap.dart';
import '../../common/widget/widget_sizedbox.dart';
import 'widget_sender_message.dart';
import '../../common/extension/extension_context.dart';
import '../../model/model_chat.dart';
import '../../model/model_user.dart';

class TeacherChatBoxWidget extends StatelessWidget {
  final ChatData chat;
  final String userEmail;
  const TeacherChatBoxWidget(
      {super.key, required this.chat, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    Stream<UserData> userStream = getUserStream(email: chat.members[1]);
    return Container(
      color: context.appColors.backgroundColor,
      padding: const EdgeInsets.all(12),
      child: StreamBuilder(
          stream: userStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData user = snapshot.data!;
              return Tap(
                onTap: () {
                  String docName = '$userEmail-${user.email}';
                  context.pushNamed('chat', pathParameters: {
                    'email': user.email
                  }, extra: {
                    'name': user.name,
                    'docName': docName,
                    'accountType': true,
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
                        child: const Image(
                            image:
                                AssetImage('assets/image/default_profile.png')),
                      ),
                    ),
                    const Width(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
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
