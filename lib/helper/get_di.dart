import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_pro/controller/auth_controller.dart';
import 'package:task_pro/controller/localization_controller.dart';
import 'package:task_pro/controller/profile_controller.dart';
import 'package:task_pro/controller/rewards_controller.dart';
import 'package:task_pro/controller/task_controller.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/data/model/language_model.dart';
import 'package:task_pro/data/repository/auth_repo.dart';
import 'package:task_pro/data/repository/language_repo.dart';
import 'package:task_pro/data/repository/profile_repo.dart';
import 'package:task_pro/data/repository/rewards_repo.dart';
import 'package:task_pro/data/repository/task_repo.dart';
import 'package:task_pro/util/app_constants.dart';


Future<Map<String, Map<String, String>>>  init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => TaskRepo(apiClient: Get.find()));
  Get.lazyPut(() => ProfileRepo(apiClient: Get.find()));
  Get.lazyPut(() => RewardsRepo(apiClient: Get.find()));


  // Controller
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => TaskController(taskRepo: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepo: Get.find()));
  Get.lazyPut(() => RewardsController(rewardsRepo: Get.find()));


  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] = _json;
  }
  return _languages;
}
