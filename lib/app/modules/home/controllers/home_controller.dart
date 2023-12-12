import 'dart:developer';

import 'package:charge_mod/app/data/api_services.dart';
import 'package:charge_mod/app/data/refresh_token/refresh_token/refresh_toke.dart';
import 'package:charge_mod/app/modules/home/model/location_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController
  @override
  void onInit() {
    scrollScontroller.addListener(locationScroll);
    // TODO: implement onInit
    super.onInit();
  }

  final count = 0.obs;

  void increment() => count.value++;

  final scrollScontroller = ScrollController();
  var totalPages = 1.obs;
  var currentPages = 1.obs;
  RxList<Result> locationLists = <Result>[].obs;
  var isnewDataLoading = false.obs;

  getLocationDatas() async {
    try {
      if (currentPages.value > totalPages.value) {
        return;
      }

      const prefs = FlutterSecureStorage();
      await RefreshToken().refreshToken();

      final token = await prefs.read(key: 'accessToken');
      log(token.toString());

      Position? position = await getCurrentLocation();
      final lat = position != null ? position.latitude.toString() : "8.5465282";
      final long =
          position != null ? position.longitude.toString() : "76.9151412";

      final response = await http.get(
          Uri.parse(
              "${ApiService().baseUrl.value}/${ApiService().organizationId}/${ApiService().projectId}/${ApiService().appVersion}/$lat/$long/all-locations?limit=10&page=${currentPages.value.toString()}"),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          });
      if (response.statusCode > 199 && response.statusCode < 300) {
        final locationDataModel = locationDataModelFromJson(response.body);
        totalPages.value = locationDataModel.data.pagination.totalPages;
        if (currentPages.value == 1) {
          locationLists.assignAll(locationDataModel.data.result);
        } else {
          locationLists.addAll(locationDataModel.data.result);
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> locationScroll() async {
    if (scrollScontroller.position.pixels ==
        scrollScontroller.position.maxScrollExtent) {
      isnewDataLoading.value = true;
      currentPages.value++;
      log("hai");
      await getLocationDatas();
      isnewDataLoading.value = false;
      update();
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          forceAndroidLocationManager: true);
      return position;
    } catch (e) {
      print("Error getting current location: $e");
      return null;
    }
  }
}
