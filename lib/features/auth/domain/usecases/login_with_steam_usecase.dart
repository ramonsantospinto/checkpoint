import 'package:dio/dio.dart';

class LoginWithSteamUsecase {
  LoginWithSteamUsecase(this._dio);

  final Dio _dio;

  Future<String> getAuthUrl({required String callbackScheme}) async {
    final res = await _dio.get(
      '/auth/steam/start',
      queryParameters: {'callbackScheme': callbackScheme},
    );
    return res.data['authUrl'] as String;
  }

  Future<String> verifyAndGetSteamId({required String resultUrl}) async {
    final res = await _dio.post(
      '/auth/steam/verify',
      data: {'resultUrl': resultUrl},
    );
    return res.data['steamId64'] as String;
  }
}
