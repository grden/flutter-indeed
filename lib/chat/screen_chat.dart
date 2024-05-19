import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import '../model/mongo/user.dart';
import '../pb/chat.pb.dart';
import '../services/auth.dart';
import '../services/chat_service.dart';
import '../services/grpc_service.dart';
import 'widget/widget_receiver_message.dart';
import 'widget/widget_sender_message.dart';

class ChatScreen extends StatefulWidget {
  //final UserModel receiver;
  final String receiverEmail;
  const ChatScreen({super.key, required this.receiverEmail});

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
        title: const Text("chat"),
      ),
      body: Center(
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
                                  bool isOwn =
                                      message.sender == AuthService.user?.email;
                                  return isOwn
                                      ? SentMessageScreen(
                                          message: message,
                                        )
                                      : ReceivedMessageScreen(message: message);
                                })),
                          )
                        : const Expanded(
                            child: Center(
                              child: Text(
                                  "No message found, start conversion with 'hi'"),
                            ),
                          )),
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
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.message),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide:
                                    const BorderSide(color: Colors.black)),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  _sendMessage();
                                },
                                icon: const Icon(Icons.send)),
                            hintText: 'Reply to this wave'),
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
    );
  }

  loadingWidget() => const Center(child: CircularProgressIndicator());
  errorWidget() => Center(
      child: Text(error ?? "Something went wrong",
          style: const TextStyle(color: Colors.red)));
}
