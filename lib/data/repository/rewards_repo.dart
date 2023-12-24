import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:task_pro/data/api/api_client.dart';
import 'package:task_pro/util/app_constants.dart';

class RewardsRepo extends GetxService {
  final ApiClient apiClient;
  RewardsRepo({required this.apiClient});

  Future<Response> getRewardsData(String month) async {

    return await apiClient
        .getData(AppConstants.REWARDS+"?month=$month",);
  }

  Future<Response> getDashPAyoutData() async {

    return await apiClient
        .getData(AppConstants.DASH_PAYOUT,);
  }
}
