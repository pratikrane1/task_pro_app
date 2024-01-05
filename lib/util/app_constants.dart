
import 'package:task_pro/data/model/language_model.dart';

import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Task Pro';
  static const String APP_VERSION = "1.0.0+50";

  static const String HOST_URL = 'http://apis.viralpro.online';

  static const String BASE_URL = '$HOST_URL/api';

  static const String LOGIN = '/login';
  static const String VERIFY_SMS_OTP = '/otp_verification';
  static const String TASK_LIST = '/show-all-assign-task';
  static const String AUTO_ASSIGN_TASK = '/assign-automate-task';
  static const String SPECIFIC_TASK = '/show-selective-assign-task';
  static const String ALL_TASK_LIST = '/show-all-assign-task-datewise';
  static const String UPLOAD_SCREENSHOT = '/verify-assign-task';
  static const String PROFILE_DATA = '/profile';
  static const String REWARDS = '/show-user-payout';
  static const String DASH_PAYOUT = '/show-dashboard-payout';
  static const String POLICY = '/policy';


  //Shared Key
  static const String USER_TOKEN = 'user_token';
  static const String USER_NUMBER = 'user_number';
  static const String NUMBER_TEMPORARY = 'number_temporary';
  static const String USER_ID = 'user_id';
  static const String REFERAL_CODE = 'referal_code';
  // static const String PROFILE_DATA = 'profile_data';
  static const String LANGUAGE_CODE = 'language_code';
  static const String COUNTRY_CODE = 'country_code';
  static const String LOCALIZATION_KEY = 'language';
  static const String NOTIFICATION = 'notification';

  static const String SHARE_CAPTION =
      'GainZ Pro के साथ जुड़ें और learning, earning, और financial empowerment की अपनी transformative journey को शुरू करें।\n\nहमारी YouTube channel को subscribe करें: https://www.youtube.com/@GainZ_Pro\n\nGainZ Pro app download करें: https://onelink.to/ghsv8j';

  //Razor Pay Key
  static const String RAZORPAY_KEY = 'rzp_live_YPqi3Ls1a4tYhP';

  ///Social links
  static const String youtube = 'https://www.youtube.com/@GainZ_Pro';
  static const String facebook = "https://www.facebook.com/gainz.proofficial";
  static const String instagram = "https://www.instagram.com/gainz.pro/";
  static const String twitter = "https://twitter.com/Gainz_Pro";


  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: "",
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    // LanguageModel(
    //     imageUrl: "",
    //     languageName: 'Hindi',
    //     countryCode: 'IN',
    //     languageCode: 'hi'),
    // LanguageModel(
    //     imageUrl: "",
    //     languageName: 'Marathi',
    //     countryCode: 'IN',
    //     languageCode: 'mr'),
  ];
}
