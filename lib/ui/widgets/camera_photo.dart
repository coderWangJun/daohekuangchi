import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:image_pickers/CropConfig.dart';
import 'package:image_pickers/Media.dart';
import 'package:image_pickers/UIConfig.dart';
import 'package:image_pickers/image_pickers.dart';

class CameraPhotoUtil {
  static GalleryMode _galleryMode = GalleryMode.image;

  // 打开相机
  static Future<List<Media>> openCamera() async {
    List<Media> _imagePaths = List();
    try {
      Media _media = await ImagePickers.openCamera(
        cropConfig: CropConfig(
          enableCrop: false,
          width: 2,
          height: 3,
        ),
      );
      if (_media != null) {
        _imagePaths.add(_media);
      }
    } on PlatformException {}
    return _imagePaths;
  }

  // 选择图片
  static Future<List<Media>> selectImages({int selectCount = 1}) async {
    List<Media> _imagePaths = List();
    try {
      _galleryMode = GalleryMode.image;
      _imagePaths = await ImagePickers.pickerPaths(
        galleryMode: _galleryMode,
        selectCount: selectCount,
        showCamera: true,
        cropConfig: CropConfig(enableCrop: false, height: 1, width: 1),
        compressSize: 500,
        uiConfig: UIConfig(
          uiThemeColor: Colors.white,
        ),
      );
    } on PlatformException {}
    return _imagePaths;
  }

  // 预览图片
  static Future<void> previewImagesByMedia({
    @required List<Media> listImagePaths,
    @required int index,
  }) async {
    ImagePickers.previewImagesByMedia(
      listImagePaths,
      index,
    );
  }
}
