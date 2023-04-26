///
//  Generated code. Do not modify.
//  source: file_service.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'file_service.pb.dart' as $0;
export 'file_service.pb.dart';

class FileServiceClient extends $grpc.Client {
  static final _$getFiles = $grpc.ClientMethod<$0.Empty, $0.File>(
      '/grpc.FileService/GetFiles',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.File.fromBuffer(value));

  FileServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.File> getFiles($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getFiles, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class FileServiceBase extends $grpc.Service {
  $core.String get $name => 'grpc.FileService';

  FileServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.File>(
        'GetFiles',
        getFiles_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.File value) => value.writeToBuffer()));
  }

  $async.Stream<$0.File> getFiles_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* getFiles(call, await request);
  }

  $async.Stream<$0.File> getFiles($grpc.ServiceCall call, $0.Empty request);
}
