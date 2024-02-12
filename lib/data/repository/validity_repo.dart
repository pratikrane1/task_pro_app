
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/util/app_constants.dart';

class ValidityRepo {
  final ApiClient apiClient;
  ValidityRepo({
    required this.apiClient,
  });

  Future<Response> getTaskProValidityData(String userId) async {
    return await apiClient
    .postData(AppConstants.TASKPRO_VALIDITY_DASH_STATUS, {
        // .postCouponData("http://destekpro.ezii.live/public/api/get_taskpro_validity_dashboard", {
      "user_id": userId,
    });
  }

  Future<Response> getTaskProValidityHistory(String userId) async {
    return await apiClient
    .postData(AppConstants.TASKPRO_VALIDITY_HISTORY, {
        // .postCouponData("http://destekpro.ezii.live/public/api/get_taskpro_validity_history", {
      "user_id": userId,
    });
  }

}
