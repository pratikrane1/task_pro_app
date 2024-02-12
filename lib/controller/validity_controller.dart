import 'package:get/get.dart';
import 'package:task_pro/data/api/api_checker.dart';
import 'package:task_pro/data/model/validity_model.dart';
import 'package:task_pro/data/repository/notification_repo.dart';
import 'package:task_pro/data/repository/validity_repo.dart';

class ValidityController extends GetxController implements GetxService {
  final ValidityRepo validityRepo;
  ValidityController({required this.validityRepo});

  ValidityModel? _taskProDashValidity;
  TaskProValidityHistory? _taskProDashValidityHistory;
  bool _isLoading = false;


  bool get isLoading => _isLoading;
  ValidityModel? get taskProDashValidity => _taskProDashValidity;
  TaskProValidityHistory? get taskProDashValidityHistory => _taskProDashValidityHistory;


  Future<ValidityModel> getTaskProValidityData(String userId) async {
    _isLoading = false;
    Response response = await validityRepo.getTaskProValidityData(userId);
    if (response.statusCode == 200) {
      _taskProDashValidity = ValidityModel.fromJson(response.body!["data"]);

      print(_taskProDashValidity);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _taskProDashValidity!;
  }

  Future<TaskProValidityHistory> getTaskProValidityHistory(String userId) async {
    _isLoading = false;
    Response response = await validityRepo.getTaskProValidityHistory(userId);
    if (response.statusCode == 200) {
      _taskProDashValidityHistory = TaskProValidityHistory.fromJson(response.body!["data"]);

      print(_taskProDashValidityHistory);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _taskProDashValidityHistory!;
  }
}
