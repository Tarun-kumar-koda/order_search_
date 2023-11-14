
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/model/user_model.dart';
import 'package:order_search/services/session_manager.dart';

class ToolBarController extends GetxController{

  var imgUrl = "".obs;
  var profileImage;
  var isImageLoaded = false.obs;
  var userModel = UserModel().obs;
  SessionManager sessionManager = SessionManager().getInstance();

  @override
  void onInit() {
    super.onInit();
    getUserObject();
  }

  void getUserObject()async{
    if(await sessionManager.getUserDetails() != null){
      userModel.value = UserModel.fromJson(await sessionManager.getUserDetails());
      if(userModel.value.image!.url != null){
          imgUrl.value = userModel.value.image!.url!;
        }
      else Container();
      getProfilePhoto();
    }
  }

  void getProfilePhoto(){
    if (imgUrl.value.length > 0) {
      Utils.checkNetworkStatus().then((value) {
        if (value) {
          profileImage = NetworkImage(imgUrl.value);
          profileImage.resolve(ImageConfiguration()).addListener(
            ImageStreamListener(
                  (info, call) {
                isImageLoaded.value = true;
              },
            ),
          );
        }
      });
    }
  }
}