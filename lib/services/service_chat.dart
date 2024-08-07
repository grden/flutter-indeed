import 'package:grpc/grpc.dart';

import '../pb/chat.pb.dart';
import 'service_grpc.dart';
import 'service_auth.dart';

class ChatService {
  static Future<List<Message>> getMessages(String email) async {
    final res = await GrpcService.client.getAllMessage(
        GetAllMessagesRequest(
          receiver: email,
        ),
        options: CallOptions(
            metadata: {'authorization': 'bearer ${AuthService.authToken}'}));
    return res.messages;
  }
}
