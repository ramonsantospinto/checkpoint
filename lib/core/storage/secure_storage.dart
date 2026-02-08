import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  const SecureStore(this._storage);

  final FlutterSecureStorage _storage;

  static const _kSteamId = 'steam_id64';

  Future<void> saveSteamId(String steamId64) =>
      _storage.write(key: _kSteamId, value: steamId64);
  Future<String?> readSteamId() => _storage.read(key: _kSteamId);
  Future<void> clear() => _storage.deleteAll();
}
