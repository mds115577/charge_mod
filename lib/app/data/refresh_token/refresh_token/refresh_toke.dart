import 'dart:convert';
import 'dart:developer';

import 'package:charge_mod/app/data/refresh_token/model/refresh_token_respnse_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../api_services.dart';
import 'package:http/http.dart' as http;

class RefreshToken {
  refreshToken() async {
    const prefs = FlutterSecureStorage();
    final token = await prefs.read(key: 'refreshToken');
    log(token!);
    final body = {"refreshToken": token};
    try {
      final response = await http.post(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/refresh"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Token $token'
          },
          body: jsonEncode(body));
      log(response.body.toString());
      if (response.statusCode == 200) {
        final refreshTokenResponseModel =
            refreshTokenResponseModelFromJson(response.body);
        await prefs.write(
            key: 'refreshToken',
            value: refreshTokenResponseModel.data.refreshToken);
        await prefs.write(
            key: 'accessToken',
            value: refreshTokenResponseModel.data.accessToken);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
