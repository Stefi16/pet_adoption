import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ImageUploadData {
  Uint8List imageBytes = Uint8List.fromList([]);
  String imageName = '';

  Future<void> init(XFile? file, FilePickerResult? imageFile) async {
    if (file != null) {
      imageName = file.name;
      imageBytes = await file.readAsBytes();
    }

    if (imageFile != null) {
      imageName = imageFile.files.first.name;
      imageBytes = imageFile.files.first.bytes ?? imageBytes;
    }
  }
}

class ImageUploaderService {
  Future<FilePickerResult?> _onUploadFromGallery(BuildContext context) async {
    final FilePickerResult? galleryResult = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    Navigator.of(context).pop();
    return galleryResult;
  }

  Future<XFile?> _onOpenCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? cameraResult =
        await picker.pickImage(source: ImageSource.camera);

    Navigator.of(context).pop();
    return cameraResult;
  }

  Future<Uint8List> compressBytes(Uint8List imageBytes) async =>
      await FlutterImageCompress.compressWithList(imageBytes, quality: 25);

  Future<ImageUploadData> showImagePickerModal(BuildContext context) async {
    final ImageUploadData data = ImageUploadData();
    final text = AppLocalizations.of(context)!;

    XFile? file;
    FilePickerResult? imageFile;
    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        useRootNavigator: false,
        context: context,
        builder: (navContext) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async => file = await _onOpenCamera(context),
              child: Text(text.takePhoto),
            ),
            CupertinoActionSheetAction(
              onPressed: () async =>
                  imageFile = await _onUploadFromGallery(context),
              child: Text(text.chooseFromLibrary),
            ),
          ],
        ),
      );
      await data.init(file, imageFile);
      return data;
    }

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        final text = AppLocalizations.of(context)!;

        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(text.choosePhoto),
                onTap: () async =>
                    imageFile = await _onUploadFromGallery(context),
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(text.openCamera),
                onTap: () async => file = await _onOpenCamera(context),
              ),
            ],
          ),
        );
      },
    );
    await data.init(file, imageFile);
    return data;
  }
}
