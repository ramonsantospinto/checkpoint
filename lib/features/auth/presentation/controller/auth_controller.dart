import 'package:flutter/foundation.dart';
import '../../../../core/storage/secure_storage.dart';

class AuthController extends ChangeNotifier {
  SecureStore? _store;

  String? _steamId;
  String? get steamId => _steamId;

  void attachStore(SecureStore store) => _store = store;

  Future<void> init() async {
    _steamId = await _store?.readSteamId();
    notifyListeners();
  }

  Future<void> setSteamId(String steamId64) async {
    _steamId = steamId64;
    await _store?.saveSteamId(steamId64);
    notifyListeners();
  }

  Future<void> logout() async {
    _steamId = null;
    await _store?.clear();
    notifyListeners();
  }
}
