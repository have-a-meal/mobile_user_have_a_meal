import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginStorage {
  static const FlutterSecureStorage storage = FlutterSecureStorage();

  static const _keyLoginDataId = "loginId";
  static const _keyLoginDataPw = "loginPw";
  static const _keyLoginDataType = "loginType";

  static Future saveLoginData({
    required String id,
    required String pw,
    required String isStudent,
  }) async {
    await storage.write(key: _keyLoginDataId, value: id);
    await storage.write(key: _keyLoginDataPw, value: pw);
    await storage.write(
        key: _keyLoginDataType, value: isStudent == "학생" ? "true" : "false");
  }

  static Future<List<String?>> getLoginData() async {
    final id = await storage.read(key: _keyLoginDataId);
    final pw = await storage.read(key: _keyLoginDataPw);
    final isStudent = await storage.read(key: _keyLoginDataType);
    return [
      id,
      pw,
      isStudent,
    ];
  }

  // 이메일을 비움
  static Future deleteLoginData() async {
    await storage.delete(key: _keyLoginDataId);
    await storage.delete(key: _keyLoginDataPw);
    await storage.delete(key: _keyLoginDataType);
  }
}
