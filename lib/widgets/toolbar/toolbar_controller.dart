
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/model/user_model.dart';
import 'package:order_search/routes/base_route.dart';
import 'package:order_search/services/session_manager.dart';
import 'package:realm/realm.dart';

import '../../realm/order_picture.dart';

class ToolBarController extends GetxController with AppData{

  var imgUrl = "".obs;
  var profileImage;
  var isImageLoaded = false.obs;
  var userModel = UserModel().obs;
  SessionManager sessionManager = SessionManager().getInstance();

  late Rx<RealmList<OrderPicture>> pictures;

  @override
  void onInit() {
    super.onInit();
    fetch();
    getUserObject();
  }

  fetch(){
    pictures = databaseHelper.realm.all<PicturesQueue>().first.queue.obs;
    pictures.refresh();
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

  // callException(){
  //   try{
  //     excc();
  //   }catch(ex,stack){
  //     print(ex);
  //     // print(stack);
  //   }
  // }
  //
  // excc(){
  //   throw Exception("exception test");
  // }

}