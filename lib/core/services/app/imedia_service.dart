import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:rxdart/rxdart.dart';

import '../../models/pic_data_wrapper.dart';
import '../../models/result.dart';

abstract class IMediaService {
  Future<Uint8List?> getImage(
    String id, {
    bool forceDownload = false,
  });
  StreamSubscription getPicSubscription(String realId, BehaviorSubject imageSbj,
      {bool forceDownload = false});
  Future<File?> pickImage<Source>(Source source);
  Future<Result<int, String, String?>> uploadImage(
      {required BehaviorSubject<PicDataWrapper> imageSbj,
      required String kind,
      required String id});
  Future<Uint8List> compressImage(Uint8List list);
  Future<File?> pickDocument();
  Future<void> downloadFile(String fileName, Uint8List bytes);
}
