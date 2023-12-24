import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/util/app_constants.dart';

class TaskRepo extends GetxService {
  final ApiClient apiClient;
  TaskRepo({required this.apiClient});

  Future<Response> getSpecificTask(String taskId) async {
    return await apiClient
        .getData(AppConstants.SPECIFIC_TASK+"/$taskId",);
  }

  Future<Response> getTaskList(String assignAt) async {
    return await apiClient
        .getData(AppConstants.TASK_LIST+"?assigned_at=$assignAt",);
  }

  Future<Response> getAllTaskList(String dataType) async {
    return await apiClient
        .getData(AppConstants.ALL_TASK_LIST+"?data_type=$dataType");
  }

  Future<Response> uploadScreenshot(XFile image,String taskId) async {
    return await apiClient
        .postMultipartData(AppConstants.UPLOAD_SCREENSHOT+"/$taskId",{},image.path);
  }
}
