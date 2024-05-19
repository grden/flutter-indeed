import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:self_project/chat/widget/widget_sender_message.dart';

import '../../common/theme/custom_shape.dart';
import '../../pb/chat.pb.dart';

class ReceivedMessageScreen extends StatelessWidget {
  final Message message;
  const ReceivedMessageScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(math.pi),
          child: CustomPaint(
            painter: CustomShape(Colors.grey.shade300),
          ),
        ),
        Flexible(
          child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeAgoCustom(message.createdAt.toDateTime()),
                          maxLines: 2,
                          style:
                              const TextStyle(color: Colors.black, fontSize: 8),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 18, top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 30),
          messageTextGroup,
        ],
      ),
    );
  }
}
