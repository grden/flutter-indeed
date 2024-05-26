import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_flip_loading.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

import '../common/widget/widget_tap.dart';
import '../pb/chat.pb.dart';
import '../services/auth.dart';
import '../services/chat_service.dart';
import '../services/grpc_service.dart';
import 'widget/widget_receiver_message.dart';
import 'widget/widget_sender_message.dart';

class ChatScreen extends StatefulWidget {
  //final UserModel receiver;
  final String receiverEmail;
  final String name;
  final String? profileImage;
  final String docName;

  const ChatScreen(
      {super.key,
      required this.receiverEmail,
      required this.name,
      this.profileImage,
      required this.docName});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  List<Message> messages = [];
  bool isLoading = false;
  final StreamController<SendMessageRequest> streamController =
      StreamController<SendMessageRequest>();
  final ScrollController scrollController = ScrollController();

  String? error;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  initAsync() async {
    await fetchChatsHistory();
    startListeningMessageRequest();
    addMessage("join_chat");
  }

  void startListeningMessageRequest() {
    final stream = GrpcService.client.sendMessage(streamController.stream,
        options: CallOptions(
            metadata: {'authorization': 'bearer ${AuthService.authToken}'}));
    stream.listen((value) {
      if (value.sender != "Server") {
        messages.add(value);
      } else {
        if (value.message.contains("has joined the room.")) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${widget.receiverEmail} has joined now.'),
            ),
          );
        }
      }
      setState(() {});
    });
  }

  void addMessage(String message) {
    // Simulate adding a message to the stream when a button is clicked
    final req = SendMessageRequest(
      message: message,
      receiver: widget.receiverEmail,
    );
    streamController.sink.add(req);
  }

  void _sendMessage() {
    final messageText = controller.text;

    if (messageText.isNotEmpty) {
      addMessage(messageText);

      controller.clear();
      setState(() {});
      scrollDown();
    }
  }

  fetchChatsHistory() async {
    try {
      isLoading = true;
      setState(() {});
      final res = await ChatService.getMessages(widget.receiverEmail);
      messages.addAll(res);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to get messages: $error'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    streamController.close();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: widget.profileImage != null
                  ? Image(
                      image: NetworkImage(widget.profileImage!),
                      fit: BoxFit.contain,
                    )
                  : const Image(
                      image: AssetImage('assets/image/default_profile.png')),
            ),
          ),
          const Width(12),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
          )
        ]),
        backgroundColor: context.appColors.backgroundColor,
        actions: [
          // _checkButton(widget.docName),
          // const FlipLoadingWidget.circle(),
          _checkStreamBuilder(widget.docName),
          const Width(16)
        ],
      ),
      body: Container(
        color: context.appColors.backgroundColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                isLoading
                    ? loadingWidget()
                    : (error != null
                        ? errorWidget()
                        : messages.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    itemCount: messages.length,
                                    itemBuilder: ((context, index) {
                                      Message message = messages[index];
                                      bool isOwn = message.sender ==
                                          AuthService.user?.email;
                                      return isOwn
                                          ? SentMessageScreen(
                                              message: message,
                                            )
                                          : ReceivedMessageScreen(
                                              message: message);
                                    })),
                              )
                            : const Expanded(
                                child: Center(
                                  child: Text(""),
                                ),
                              )),
                const Line(),
                Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            maxLines: null,
                            controller: controller,
                            enabled: !isLoading,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 0),
                              filled: true,
                              fillColor: context.appColors.textFieldColor,
                              iconColor: context.appColors.primaryText,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.appColors.primaryColor,
                                      width: 0.6),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.appColors.primaryColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(12)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _sendMessage();
                                  },
                                  icon: const Icon(Icons.send)),
                              //hintText: 'Reply to this wave',
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty) {}
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadingWidget() => const Center(child: CircularProgressIndicator());
  errorWidget() => Center(
        child: Text(error ?? "Something went wrong",
            style: TextStyle(color: context.appColors.errorColor)),
      );

  Widget _checkButton(String docName) {
    return Tap(
      onTap: () {
        final db = FirebaseFirestore.instance;
        final chatRef = db.collection('chat');
        chatRef.doc(docName).update({'studentOK': true});
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border:
                Border.all(color: context.appColors.primaryColor, width: 2.4)),
        child: Icon(
          Icons.check,
          color: context.appColors.primaryColor,
        ),
      ),
    );
  }

  Widget _matchedButton() {
    return AvatarGlow(
      glowRadiusFactor: 0.6,
      glowCount: 1,
      glowColor: const Color.fromARGB(255, 30, 98, 190),
      repeat: false,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 101, 179, 245),
            Color.fromARGB(255, 30, 98, 190)
          ], begin: Alignment.topLeft),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _checkStreamBuilder(String docName) {
    final db = FirebaseFirestore.instance;
    final chatRef = db.collection('chat').doc(docName);

    return StreamBuilder(
        stream: chatRef.snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.hasData) {
            int condition = 0;
            final doc = snapshot.data!;
            if (doc['studentOK'] && doc['teacherOK']) {
              condition = 2;
            } else if (doc['studentOK'] || doc['teacherOK']) {
              condition = 1;
            }

            switch (condition) {
              case 1:
                return const FlipLoadingWidget.circle();
              case 2:
                return _matchedButton();
              default:
                return _checkButton(docName);
            }
          }
          return _checkButton(docName);
        });
  }
}
