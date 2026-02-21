import 'dart:io';
import 'package:dio/dio.dart';

class MultipartHelper {
  static Future<FormData> build({
    Map<String, dynamic>? fields,
    File? singleFile,
    String? singleFileKey,
    List<File>? files,
    String? filesKey,
  }) async {
    final formData = FormData();

    if (fields != null) {
      fields.forEach((key, value) {
        if (value != null) {
          formData.fields.add(MapEntry(key, value.toString()));
        }
      });
    }
    if (singleFile != null && singleFileKey != null) {
      formData.files.add(
        MapEntry(
          singleFileKey,
          await MultipartFile.fromFile(
            singleFile.path,
            filename: singleFile.path.split('/').last,
          ),
        ),
      );
    }

    if (files != null && filesKey != null) {
      for (final file in files) {
        formData.files.add(
          MapEntry(
            filesKey,
            await MultipartFile.fromFile(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      }
    }

    return formData;
  }
}
