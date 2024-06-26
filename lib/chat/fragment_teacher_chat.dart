import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/widget/widget_line.dart';
import '../model/model_chat.dart';
import '../provider/provider_user.dart';
import '../common/widget/widget_profile_appbar.dart';
import 'widget/widget_teacher_chatbox.dart';

class TeacherChatFragment extends ConsumerStatefulWidget {
  const TeacherChatFragment({super.key});

  @override
  ConsumerState<TeacherChatFragment> createState() => _ChatFragmentState();
}

class _ChatFragmentState extends ConsumerState<TeacherChatFragment> {
  Stream<List<ChatData>>? chatStream;

  @override
  void initState() {
    super.initState();
    chatStream = getChatStream();
  }

  void retryLoad() {
    setState(() {
      chatStream = getChatStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCredential = ref.watch(userCredentialProvider);
    return Column(
      children: [
        const ProfileAppBar(),
        Expanded(
          child: StreamBuilder(
              stream: chatStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ChatData> chatList = snapshot.data!;
                  if (chatList.isEmpty) {
                    const Center(
                        child: Text(
                      '학생들과 채팅을 시작해 보세요!',
                      style: TextStyle(fontSize: 19),
                    ));
                  } else {
                    return ListView.separated(
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        final chat = chatList[index];
                        return TeacherChatBoxWidget(
                          chat: chat,
                          userEmail: userCredential!.user!.email!,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Line();
                      },
                    );
                  }
                }
                if (snapshot.hasError) {
                  print("Stream Error: ${snapshot.error}");
                  return TextButton(
                      onPressed: retryLoad,
                      child: const Center(child: Text("뭔가 문제가 생겼습니다. 재시도하기")));
                }
                if (!snapshot.hasData) {
                  return const Center(
                      child: Text(
                    '채팅 기록이 없습니다.',
                    style: TextStyle(fontSize: 19),
                  ));
                } else {
                  return const Center(
                      child: Text(
                    '채팅 기록이 없습니다.',
                    style: TextStyle(fontSize: 19),
                  ));
                }
              }),
        )
      ],
    );
  }

  Stream<List<ChatData>> getChatStream() async* {
    final db = FirebaseFirestore.instance;
    final userCredential = ref.watch(userCredentialProvider);
    List<ChatData> chats = [];

    final snapshot = db
        .collection('chat')
        .where('members', arrayContains: userCredential!.user!.email)
        .orderBy('lastTime', descending: true)
        .snapshots();

    await for (final query in snapshot) {
      chats = [];
      for (var doc in query.docs) {
        final chat = ChatData.fromJson(doc.data());
        chats.add(chat);
        print(chat.lastMsg);
      }
      yield chats;
    }
  }
}
