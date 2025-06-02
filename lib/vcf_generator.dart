import 'package:vcard_vcf/vcard.dart';

String generateVCF(String name, String phone) {
  final vCard = VCard()
    ..firstName = name
    ..workPhone = phone;
  return vCard.getFormattedString();
}

String createBulkVCF(String code, int start, int end) {
  final buffer = StringBuffer();
  for (int i = start; i <= end; i++) {
    final name = 'ZAID BADANA $i';
    final phone = '$code$i';
    buffer.writeln(generateVCF(name, phone));
  }
  return buffer.toString();
}
