import 'package:get/get.dart';
import 'package:task_pro/data/api/api_checker.dart';
import 'package:task_pro/data/model/profile_model.dart';
import 'package:task_pro/data/repository/profile_repo.dart';


class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileController({required this.profileRepo});

  bool _isLoading = false;
  bool _isPolicyLoading = false;
  ProfileModel? _profileData;
  String? _policyData;

  bool get isLoading => _isLoading;
  bool get isPolicyLoading => _isPolicyLoading;
  ProfileModel? get profileData => _profileData;
  String? get policyData => _policyData ?? "";


  Future<ProfileModel> getProfileData() async {
    _isLoading = false;
    // _profileData = [];
    Response response = await profileRepo.getProfileData();
    if (response.statusCode == 200) {
      _profileData = ProfileModel.fromJson(response.body!["data"]);
      print(_profileData);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _profileData!;
  }

  Future<void> getPolicy(String policy, String termsAndConditions) async {
    // if (_legalPolicies == null) {
    _policyData = null;
    Response response = await profileRepo.getPolicy(policy,termsAndConditions);
    if (response.statusCode == 200) {

      _policyData = response.body["data"];
      print(_policyData);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    // }
  }
}
