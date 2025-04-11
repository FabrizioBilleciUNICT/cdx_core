import 'dart:typed_data';
import 'package:cdx_core/core/models/pic_data_image.dart';
import 'package:cdx_core/core/models/pic_media_image.dart';

class PicDataWrapper extends PicDataImage {
  final String id;
  final Uint8List? bytes;

  PicDataWrapper({required this.id, super.loading, this.bytes})
      : super(source: bytes ?? PicMediaImage(id: id));
}
