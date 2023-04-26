import 'dart:ffi';

import 'package:grpc_array_bug_demo/src/generated/file_service.pbgrpc.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'dart:math' as m;

const fileSize = 0x100000;

void main(List<String> args) async {
  final server = grpc.Server([FileService()]);
  await server.serve(port: 8080);
  print('Server listening on port ${server.port}...');
}

final r = m.Random();
final file = List.generate(fileSize, (i) {
  return r.nextInt(0xff);
});

class FileService extends FileServiceBase {
  int callCount = 0;

  @override
  Stream<File> getFiles(grpc.ServiceCall call, Empty request) async* {
    try {
      for (var index = 0; index < 30; index++) {
        final imgRes = File(contents: file);
        yield imgRes;
      }
    } catch (ex) {
      print('Could not send with $ex');
    }
  }
}
