import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/model/user_model.dart';

import '../../../Utils/logger.dart';
import '../../base_route.dart';

class ProfileController extends GetxController with AppData {
  File? image;
  var imgUrl = "".obs;
  var profileImage;
  RxBool isImageLoaded = false.obs;
  Rx<UserModel> userModel = UserModel().obs;
  Rx<String> currentVersion = "".obs;
  Rx<File> profileImageFile = File("").obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getUserObject();
  }

  void getUserObject() async {
    //currentVersion.value = await Utils.getDeviceDetails();
    if (await sessionManager.getUserDetails() != null) {
      userModel.value = UserModel.fromJson(await sessionManager.getUserDetails());
      if (userModel.value.image != null && userModel.value.image!.url != null)
        imgUrl.value = userModel.value.image!.url!;
      if (userModel.value.firstName != null) firstNameController.text = userModel.value.firstName!;
      if (userModel.value.lastName != null) lastNameController.text = userModel.value.lastName!;
      if (userModel.value.mobileNumber != null) mobileController.text = userModel.value.mobileNumber!;
      getProfilePhoto();
    }
  }

  void getProfilePhoto() {
    if (imgUrl.value.length > 0) {
      Utils.checkNetworkStatus().then((value) {
        if (value) {
          profileImage = NetworkImage(imgUrl.value);
          profileImage.resolve(ImageConfiguration()).addListener(
            ImageStreamListener(
              (ImageInfo info, bool call) {
                isImageLoaded.value = true;
              },
            ),
          );
        }
      });
    }
  }

  Future updateProfileName() async {
    Utils.showLoadingDialog();
    String userId = await sessionManager.getUserId();
    String accessToken = await sessionManager.getAccessToken();
    String refreshToken = await sessionManager.getRefreshToken();
    var res = await networkUtil.updateDio("${ApiConstant.endPoint.UPDATE_USER_PROFILE}${userId}",
        body: {
          "first_name": firstNameController.value.text,
          "last_name": lastNameController.value.text,
          "id": userId,
          "roles": userModel.value.roles,
          "employee_code": userModel.value.employeeCode ?? "",
          "mobile_number": userModel.value.mobileNumber ?? "",
        },
        headers: ApiConstant().getHeaders(accessToken));
    Utils.hideLoadingDialog();
    if (res != null) {
      if (res.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(res.data);
        sessionManager.setUserDetails(userModel);
        Utils.showToastMessage("Profile data saved successfully");
      } else if (res.statusCode == 401) {
        getTokenValidation(refreshToken);
      }
    }
  }

  Future getProfile() async {
    Utils.showLoadingDialog();
    String accessToken = await sessionManager.getAccessToken();
    String refreshToken = await sessionManager.getRefreshToken();
    var res = await networkUtil.getDio(
      "${ApiConstant.endPoint.GET_USER_PROFILE}",
      "GET_PROFILE",
      headers: ApiConstant().getHeaders(accessToken),
    );
    Utils.hideLoadingDialog();
    if (res != null) {
      if (res.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(res.data);
        sessionManager.setUserDetails(userModel);
        Utils.showToastMessage("Profile data fetched successfully");
        getUserObject();
      } else if (res.statusCode == 401) {
        getTokenValidation(refreshToken);
      }
    }
  }

  getTokenValidation(String refreshToken) async {
    Utils.showLoadingDialog();
    try {
      var res = await networkUtil.postDio(ApiConstant.endPoint.REFRESH_TOKEN, "REFRESH_TOKEN",
          body: getTokenParam(refreshToken));
      Utils.hideLoadingDialog();
      if (res != null) {
        if (res.statusCode == 200) {
          sessionManager.setRefreshToken(res.data["refresh_token"]);
          sessionManager.setAccessToken("bearer ${res.data["access_token"]}");
        } else if (res.statusCode == 401) {
          sessionManager.clearPreferences();
          Get.offNamed(AppLinks.loginNamedRoute);
          Utils.showToastMessage("Token expired");
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future updateProfilePicture() async {
    try {
      Utils.showLoadingDialog();
      String userId = await sessionManager.getUserId();
      String accessToken = await sessionManager.getAccessToken();
      String refreshToken = await sessionManager.getRefreshToken();

      List<dio.MultipartFile> filesList = <dio.MultipartFile>[];
      String fileName;
      dio.MultipartFile multipartFile;
      fileName = profileImageFile.value.path.split('/').last;
      multipartFile =
          await dio.MultipartFile.fromFile(profileImageFile.value.path.toString(), filename: fileName.toString());
      filesList.add(multipartFile);

      dio.FormData data = dio.FormData.fromMap({
        "first_name": firstNameController.value.text,
        "last_name": lastNameController.value.text,
        "id": userId,
        "roles": userModel.value.roles,
        "employee_code": userModel.value.employeeCode ?? "",
        "mobile_number": userModel.value.mobileNumber ?? "",
      });

      for (var filePart in filesList) {
        data.files.add(MapEntry("image", filePart));
      }

      var res = await networkUtil.updateDio("${ApiConstant.endPoint.UPDATE_USER_PROFILE}${userId}",
          body: data, headers: ApiConstant().getHeaders(accessToken));
      if (res != null) {
        if (res.statusCode == 200) {
          UserModel userModel = UserModel.fromJson(res.data);
          sessionManager.setUserDetails(userModel);
          Utils.showToastMessage("Profile data saved successfully");
        } else if (res.statusCode == 401) {
          getTokenValidation(refreshToken);
        }
      }
    } catch (ex) {
      Logger.logMessenger(msgTitle: AppLinks.profileNamedRoute, msgBody: {"Exception": ex});
    }
    Utils.hideLoadingDialog();
  }

  Map<String, dynamic> getTokenParam(String refreshToken) {
    var body = <String, dynamic>{
      ApiConstant.param.REFRESH_TOKEN: refreshToken,
      ApiConstant.param.CLIENT_ID: ApiConstant.clientId,
      ApiConstant.param.CLIENT_SECRET: ApiConstant.clientSecretKey,
      ApiConstant.param.GRANT_TYPE: "refresh_token",
    };
    return body;
  }
}
