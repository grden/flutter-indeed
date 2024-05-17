import 'package:grpc/grpc.dart';
import 'package:self_project/pb/service.pbgrpc.dart';

class GrpcService {
  static String host = "127.0.0.1";
  static int port = 9090;
  static updateChannel() {
    channel = ClientChannel(host,
        port: port,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
  }

  static var channel = ClientChannel(host,
      port: port,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  static var client = GrpcServerServiceClient(channel);
}
