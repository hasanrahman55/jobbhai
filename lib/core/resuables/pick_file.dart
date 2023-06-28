import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class PickFile {
  static Future<File> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(image!.path);
  }

  static Future<File> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      dialogTitle: 'Select your CV',
      allowMultiple: false,
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );
    
    return File(result!.files.single.path!);
  }
}
