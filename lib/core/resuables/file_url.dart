class FileUrl {
  static String fileUrl({required String fileId,}) {
    String imageUrl =
        'https://cloud.appwrite.io/v1/storage/buckets/646d4249e341cea8de82/files/$fileId/view?project=6469d2c32f8e4b8ceb66&mode=admin';
    return imageUrl;
  }
}
