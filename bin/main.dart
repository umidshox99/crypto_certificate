import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  // Replace these keys with your own keys in a real-world scenario
  final key = encrypt.Key.fromUtf8("chakana_pay_1999chakana_pay_1999");
  final iv = encrypt.IV.fromUtf8("chakana_pay_1999");

  // File to be encrypted and decrypted
  final inputFile = File('/Users/umidjonshoniyozov/IdeaProjects/lesson/bin/mobilpay.pfx');
  final encryptedFile = File('/Users/umidjonshoniyozov/IdeaProjects/lesson/bin/its_secure.bro');
  final decryptedFile = File('/Users/umidjonshoniyozov/IdeaProjects/lesson/bin/mobilpay1.pfx');


  // Read the content of the input file as bytes
  List<int> inputBytes = inputFile.readAsBytesSync();

  // Encrypt the content
  List<int> encryptedBytes = encryptBytes(inputBytes, key, iv);

  // Write the encrypted content to a file
  encryptedFile.writeAsBytesSync(encryptedBytes);

  // Decrypt the content
  List<int> decryptedBytes = decryptBytes(encryptedBytes, key, iv);

  // Write the decrypted content to a file
  decryptedFile.writeAsBytesSync(decryptedBytes);


  // decryptedFile.writeAsBytesSync(encryptedFile.readAsBytesSync());
}

List<int> encryptBytes(List<int> bytes, encrypt.Key key, encrypt.IV iv) {
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  final encrypted = encrypter.encryptBytes(bytes, iv: iv);
  return encrypted.bytes;
}

List<int> decryptBytes(List<int> encryptedBytes, encrypt.Key key, encrypt.IV iv) {
  final encrypter = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
  final decrypted = encrypter.decryptBytes(encrypt.Encrypted(Uint8List.fromList(encryptedBytes)), iv: iv);
  return decrypted;
}
