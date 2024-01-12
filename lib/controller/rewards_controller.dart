import 'package:get/get.dart';
import 'package:task_pro/data/api/api_checker.dart';
import 'package:task_pro/data/model/profile_model.dart';
import 'package:task_pro/data/model/rewards_model.dart';
import 'package:task_pro/data/repository/profile_repo.dart';
import 'package:task_pro/data/repository/rewards_repo.dart';


class RewardsController extends GetxController implements GetxService {
  final RewardsRepo rewardsRepo;
  RewardsController({required this.rewardsRepo});

  bool _isLoading = false;
  bool _isTodaysPayoutLoading = false;
  RewardsModel? _rewardsData;
  RewardsModel? _dashPayoutData;

  bool get isLoading => _isLoading;
  bool get isTodaysPayoutLoading => _isTodaysPayoutLoading;
  RewardsModel? get rewardsData => _rewardsData;
  RewardsModel? get dashPayoutData => _dashPayoutData;


  Future<RewardsModel> getRewardsData(String date) async {
    _isLoading = false;
    _rewardsData = null;
    Response response = await rewardsRepo.getRewardsData(date);
    if (response.statusCode == 200) {

      _rewardsData = RewardsModel.fromJson(response.body["data"]);

      print(_rewardsData);
      _isLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _rewardsData!;
  }


  Future<RewardsModel> getTodaysPayoutData() async {
    _isTodaysPayoutLoading = false;
    _dashPayoutData = null;
    Response response = await rewardsRepo.getDashPAyoutData();
    if (response.statusCode == 200) {

      _dashPayoutData = RewardsModel.fromJson(response.body["data"]);

      // final Iterable refactorProductList = response.body["data"] ?? [];
      // _rewardsData = refactorProductList.map((item) {
      //   return RewardsModel.fromJson(item);
      // }).toList();

      print(_dashPayoutData);
      _isTodaysPayoutLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _dashPayoutData!;
  }


}
