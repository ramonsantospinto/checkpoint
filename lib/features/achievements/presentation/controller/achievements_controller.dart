import 'package:flutter/foundation.dart';

class AchievementsController extends ChangeNotifier {
  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;

  Future<void> init() async {}

  void setLoading(bool v) { _loading = v; notifyListeners(); }
  void setError(String? v) { _error = v; notifyListeners(); }
}
