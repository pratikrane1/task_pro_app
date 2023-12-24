import 'package:flutter/material.dart';
import 'package:task_pro/data/model/language_model.dart';
import 'package:task_pro/util/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({required BuildContext context}) {
    return AppConstants.languages;
  }
}
