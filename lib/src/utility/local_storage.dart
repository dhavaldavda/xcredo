import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> setLocalStorage(String key, String? value) async {
  final storage = FlutterSecureStorage();
  await storage.write(key: key, value: value);
}

Future<String?> getLocalStorage(String key) async {
  final storage = FlutterSecureStorage();
  return await storage.read(key: key);
}

void removeAllLocalStorage(String key) async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: key);
}
