import 'package:get/get.dart';
import 'package:task_pro/view/base/custom_snackbar.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      showCustomSnackBar(response.statusText.toString());
    } else {
      showCustomSnackBar(response.statusText.toString());
    }
  }
}
