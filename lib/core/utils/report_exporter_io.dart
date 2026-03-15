import 'dart:convert';
import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> saveCsvReportImpl({
  required String filename,
  required String csvContent,
}) async {
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}\\$filename');

  await file.writeAsString(
    csvContent,
    encoding: utf8,
    flush: true,
  );

  final savedPath = await FlutterFileDialog.saveFile(
    params: SaveFileDialogParams(
      sourceFilePath: file.path,
      fileName: filename,
    ),
  );

  if (savedPath == null) {
    throw const FileSystemException('Save cancelled');
  }
}

Future<void> shareCsvReportImpl({
  required String filename,
  required String csvContent,
}) async {
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}\\$filename');

  await file.writeAsString(csvContent);

  await Share.shareXFiles(
    [XFile(file.path)],
    subject: filename,
    text: filename,
  );
}
