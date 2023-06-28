import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/appwrite_constant.dart';

final clientProvider = Provider((ref) {
  Client client =
      Client(endPoint: AppWriteConstant.serverUrl, selfSigned: true)
          .setProject(AppWriteConstant.projectId);
  return client;
});

final appwriteAuthProvider = Provider((ref) {
  return Account(ref.watch(clientProvider));
});

final appwriteDatabaseProvider = Provider((ref) {
  return Databases(ref.watch(clientProvider));
});

final appwriteStorage = Provider((ref) {
  return Storage(ref.watch(clientProvider));
});
final appwriteRealTime = Provider((ref) {
  return Realtime(ref.watch(clientProvider));
});
