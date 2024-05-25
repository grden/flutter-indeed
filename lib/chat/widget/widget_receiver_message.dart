import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:self_project/chat/widget/widget_sender_message.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Transform(
        //   alignment: Alignment.center,
        //   transform: Matrix4.rotationY(math.pi),
        //   child: CustomPaint(
        //     painter: CustomShape(Colors.grey.shade300),
        //   ),
        // ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: context.appColors.cardColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                boxShadow: [context.appShadows.cardShadow]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  style: TextStyle(
                      color: context.appColors.primaryText,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
        const Width(12),
        Flexible(
          child: Text(
            timeAgoCustom(message.createdAt.toDateTime()),
            maxLines: 2,
            style: TextStyle(
                color: context.appColors.secondaryText,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 50.0, left: 16, top: 16, bottom: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 12),
          messageTextGroup,
        ],
      ),
    );
  }
}
