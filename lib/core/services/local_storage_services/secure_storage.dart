import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // Singleton instance
  SecureStorageHelper._internal();
  static final SecureStorageHelper instance = SecureStorageHelper._internal();

  // Secure storage config
  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(),
  );

  // Keys
  static const String _keyJwtToken = 'jwt_token';
  static const String _keyIsLoggedIn = 'is_logged_in';

  // ================= JWT TOKEN =================

  Future<void> saveToken(String token) async {
    await _storage.write(key: _keyJwtToken, value: token);
    await setLoggedIn(true); // Mark user as logged in when token is saved
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _keyJwtToken);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _keyJwtToken);
    await setLoggedIn(false); // Mark user as logged out when token is deleted
  }

  // ================= LOGIN FLAG =================

  Future<void> setLoggedIn(bool value) async {
    await _storage.write(
      key: _keyIsLoggedIn,
      value: value.toString(), // SecureStorage stores strings only
    );
  }

  Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _keyIsLoggedIn);
    return value == 'true';
  }

  // ================= LOGOUT / CLEAR =================

  Future<void> clearAll() async {
    await _storage.deleteAll();
    await setLoggedIn(false); // Mark user as logged out when all data is cleared
  }
}