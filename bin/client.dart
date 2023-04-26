import 'package:grpc/grpc.dart';
import 'package:grpc_array_bug_demo/src/generated/file_service.pbgrpc.dart';

final channel = ClientChannel('127.0.0.1',
    port: 8080,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()));
final stub = FileServiceClient(channel);

void main(List<String> args) async {
  for (var i = 0; i < 10; i++) {
    print('Will get files ($i iteration)');
    await runGetFiles();
  }
  await channel.shutdown();
  print('\n\nDONE');
}

Future<void> runGetFiles() async {
  final call = stub.getFiles(Empty());
  var count = 0;
  try {
    await for (var number in call) {
      count++;
      print(
          'Received file with ${number.contents.length} bytes (count=$count)');
      if (count > 5) {
        await call.cancel();
      }
    }
  } on GrpcError catch (e) {
    print('Caught: $e');
  }
  print('Final count: $count');
}
