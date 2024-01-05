
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_compression_flutter/image_compression_flutter.dart';
import 'package:task_pro/data/api/api_checker.dart';
import 'package:task_pro/data/model/all_task_model.dart';
import 'package:task_pro/data/model/response_model.dart';
import 'package:task_pro/data/model/task_model.dart';
import 'package:task_pro/data/repository/task_repo.dart';
import 'package:task_pro/view/base/custom_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class TaskController extends GetxController implements GetxService{
  final TaskRepo taskRepo;
  TaskController({required this.taskRepo});


  XFile? _pickedFile;
  XFile? _pickedFile1;
  Uint8List? _rawFile;
  ImagePicker picker = ImagePicker();
  TaskModel? _taskList;
  TaskListModel? _taskData;
  List<AllTaskModel>? _allTaskList;
  List<AllTaskModel>? _allTaskListScreen;
  bool _isSpecificTaskLoading = false;
  bool _isGetTaskLoading = false;
  bool _isGetAllTaskLoading = false;
  bool _isUploadLoading = false;



  TaskModel? get taskList => _taskList;
  TaskListModel? get taskData => _taskData;
  List<AllTaskModel>? get allTaskList => _allTaskList;
  List<AllTaskModel>? get allTaskListScreen => _allTaskListScreen;
  bool get isSpecificTaskLoading => _isSpecificTaskLoading;
  bool get isGetTaskLoading => _isGetTaskLoading;
  bool get isGetAllTaskLoading => _isGetAllTaskLoading;
  bool get isUploadLoading => _isUploadLoading;
  Uint8List? get rawFile => _rawFile;
  XFile? get pickedFile => _pickedFile;

  void initData() {
    _pickedFile = null;
    _rawFile = null;
  }

  Future<TaskListModel> getSpecificTask(String taskId) async {
    // int id = 85;
    _isSpecificTaskLoading = false;
    _taskData = null;
    Response response = await taskRepo.getSpecificTask(taskId);
    if (response.statusCode == 200) {
      _taskData = TaskListModel.fromJson(response.body["data"]);
      // _taskList = refactorProductList.map((item) {
      //   return TaskModel.fromJson(item);
      // }).toList();
      print(_taskList);
      _isSpecificTaskLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _taskData!;
  }


  Future<TaskModel> getTask(String assignAt) async {
    // int id = 85;
    _isGetTaskLoading = false;
    _taskList = null;
    Response response = await taskRepo.getTaskList(assignAt);
    if (response.statusCode == 200) {
      _taskList = TaskModel.fromJson(response.body["data"]);
      // _taskList = refactorProductList.map((item) {
      //   return TaskModel.fromJson(item);
      // }).toList();
      print(_taskList);
      _isGetTaskLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _taskList!;
  }


  Future<List<AllTaskModel>> getAllTask(String dataType) async {
    // int id = 85;
    _isGetAllTaskLoading = false;
    _allTaskList = [];
    Response response = await taskRepo.getAllTaskList(dataType);
    if (response.statusCode == 200) {
      final Iterable refactorProductList = response.body["data"] ?? [];
      _allTaskList = refactorProductList.map((item) {
        return AllTaskModel.fromJson(item);
      }).toList();
      print(_allTaskList);
      _isGetAllTaskLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _allTaskList!;
  }

  Future<List<AllTaskModel>> getAllTaskList(String dataType) async {
    // int id = 85;
    _isGetAllTaskLoading = false;
    _allTaskListScreen = [];
    Response response = await taskRepo.getAllTaskList(dataType);
    if (response.statusCode == 200) {
      final Iterable refactorProductList = response.body["data"] ?? [];
      _allTaskListScreen = refactorProductList.map((item) {
        return AllTaskModel.fromJson(item);
      }).toList();
      print(_allTaskListScreen);
      _isGetAllTaskLoading = true;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    return _allTaskListScreen!;
  }


  Future<ResponseModel> uploadScreenShot(String taskId) async {
    // _pickedFile = null;
    // _rawFile = null;
    ResponseModel? _responseModel;
    Response response = await taskRepo.uploadScreenshot(_pickedFile!,taskId);
    if (response.statusCode == 200) {
      _responseModel = ResponseModel(true, response.bodyString.toString(),1);
      // getProfileData();
      _pickedFile = null;
      _rawFile = null;
      update();
      _isUploadLoading = true;
      showCustomSnackBar(response.body["message"].toString(),isError: false);
    } else {
      ApiChecker.checkApi(response);
      showCustomSnackBar(response.body["message"].toString(),isError: true);
      _pickedFile = null;
      _rawFile = null;
    }
    update();
    return _responseModel!;
    // }
  }


  Future<String> saveImage(Uint8List bytes,) async{
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.', '_').replaceAll(':','_');
    final name = "Screenshot_$time";
    final result = await ImageGallerySaver.saveImage(bytes,name:name);
    // final path = result['filePath']+"/$name";
    Directory? temp;

    if (Platform.isIOS) {
      temp = await getApplicationDocumentsDirectory();
    } else {
      temp = await getTemporaryDirectory();
    }
    // final temp = await getTemporaryDirectory();
    final path = '${temp.path}/image.jpg';
    File(path).writeAsBytesSync(bytes);
    print(path);
    _pickedFile = XFile(path);
    print(_pickedFile);
    // return result['filePath'];
    return _pickedFile!.path;
  }



  Future pickGalleryImage(String taskId) async {
    try{
      _pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (_pickedFile != null) {
        final bytes = (await _pickedFile!.readAsBytes()).lengthInBytes;
        // if(bytes <= 1000000){
          print("Image Size : ${bytes}");
          _pickedFile1 = await compressImage(_pickedFile!);
          _rawFile = await _pickedFile1!.readAsBytes();
          // uploadScreenShot(taskId);
        // }else{
        //   showCustomSnackBar("image_should_be_less_than_1mb".tr,isError: true);
        // }
      }else{
        throw Exception('File is not available');
      }
    } catch (e){
      _pickedFile = null;
      print(e);
    }
    update();
  }

  static Future<XFile> compressImage(XFile file) async {
    final ImageFile _input =
    ImageFile(filePath: file.path, rawBytes: await file.readAsBytes());
    final Configuration _config = Configuration(
      outputType: ImageOutputType.webpThenPng,
      useJpgPngNativeCompressor: false,
      quality: (_input.sizeInBytes / 1048576) < 2
          ? 90
          : (_input.sizeInBytes / 1048576) < 5
          ? 50
          : (_input.sizeInBytes / 1048576) < 10
          ? 10
          : 1,
    );
    final ImageFile _output = await compressor
        .compress(ImageFileConfiguration(input: _input, config: _config));
    if (kDebugMode) {
      print('Input size : ${_input.sizeInBytes / 1048576}');
      print('Output size : ${_output.sizeInBytes / 1048576}');
    }
    return XFile.fromData(_output.rawBytes);
  }

}