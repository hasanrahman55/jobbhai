import 'dart:io';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/apis/appwrite_injects.dart';
import 'package:jobbhai/constants/appwrite_constant.dart';
import 'package:path_provider/path_provider.dart';

final storageAPIProvider = Provider((ref) {
  return StorageAPI(storage: ref.watch(appwriteStorage));
});

class StorageAPI {
  final Storage _storage;

  StorageAPI({required Storage storage}) : _storage = storage;

  Future<String> uploadFile({required File file, required bool isCv}) async {
    final upload = await _storage.createFile(
      bucketId:
          isCv ? AppWriteConstant.cVBucketId : AppWriteConstant.profileBucketId,
      fileId: ID.unique(),
      file: InputFile.fromPath(path: file.path, filename: file.path),
    );
    return upload.$id;
  }

  Future<String> viewCv({required String fileId}) async {
    Directory tempDir = await getTemporaryDirectory();
    final cv = File('${tempDir.path}/${Random().nextInt(123)}.pdf');
    final serverPdf = await _storage.getFileDownload(
      bucketId: AppWriteConstant.cVBucketId,
      fileId: fileId,
    );
    final file = await cv.writeAsBytes(serverPdf);
    return file.path;
  }
}
