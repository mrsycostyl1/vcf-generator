import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> requestPermission() async {
  return await Permission.storage.request().isGranted;
}

Future<void> saveVCF(String content) async {
  final directory = await getExternalStorageDirectory();
  final path = '${directory!.path}/ZAID BADANA VCF.vcf';
  final file = File(path);
  await file.writeAsString(content);
}
