import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

import '../../common/theme/custom_shape.dart';
import '../../pb/chat.pb.dart';

class SentMessageScreen extends StatelessWidget {
  final Message message;

  const SentMessageScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
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
        const Width(12),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.appColors.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.message,
                  style: TextStyle(
                      color: context.appColors.inverseText,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
        // CustomPaint(painter: CustomShape(context.appColors.primaryColor)),
      ],
    ));

    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 50, top: 16, bottom: 0),
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

String timeAgoCustom(DateTime d) {
  // <-- Custom method Time Show  (Display Example  ==> 'Today 7:00 PM')     // WhatsApp Time Show Status Shimila
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "년" : "년"} 전";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "달" : "달"} 전";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "주" : "주"} 전";
  }
  if (diff.inDays > 0) {
    return DateFormat.E().add_jm().format(d);
  }
  if (diff.inHours > 0) {
    return DateFormat('jm').format(d);
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "분" : "분"} 전";
  }
  return "방금";
}
