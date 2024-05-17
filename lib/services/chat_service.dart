import 'package:grpc/grpc.dart';
import 'package:self_project/pb/chat.pb.dart';
import 'package:self_project/services/grpc_service.dart';
import 'package:self_project/services/auth.dart';

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
