import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/api_constant.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/routes/base_route.dart';
import 'package:order_search/routes/profile_screen/controller/profile_controller.dart';
import 'package:order_search/services/session_manager.dart';
import 'package:order_search/widgets/pod_images_widget/file_manager.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends BaseRoute<ProfileView> {
  ProfileController profileController = Get.put(ProfileController());
  SessionManager sessionManager = SessionManager().getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  profileToolBar(),
                  profileImage(),
                  //changeProfilePhoto(),
                  employeeCode(),
                  userDetailsWidget(),
                  SizedBox(
                    height: getMediaQueryHeight(context, 0.2),
                  ),
                  versionInfo(),
                  buttonView(),
                  // logOutButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget profileToolBar() {
    print("toolbar build");
    return Container(
      margin: EdgeInsets.only(left: getMediaQueryHeight(context, 0.01), right: getMediaQueryHeight(context, 0.01)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back(result: [
                    {'backValue': 'true'}
                  ]);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.arrow_back_ios),
                iconSize: getMediaQueryWidth(context, 0.07),
              ),
              Container(
                width: getMediaQueryWidth(context, 0.5),
                child: Text(
                  'Profile',
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(fontSize: getMediaQueryWidth(context, 0.052), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          ElevatedButton(
            child: Icon(Icons.logout),
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(CircleBorder()),
                backgroundColor: MaterialStatePropertyAll(Colors.red.shade700),
                // foregroundColor: MaterialStatePropertyAll(Colors.red),
                visualDensity: VisualDensity.comfortable,
                iconSize: MaterialStatePropertyAll(20)),
            onPressed: () async {
            if(await Utils.showConfirmDialog("Are you sure, you want to logout?") ?? false) {
                Utils.showLoadingDialog(msg: "logging out");
                await sessionManager.logOut();
                Utils.hideLoadingDialog();
              }
            },
          ),
          IconButton(
            onPressed: () {
              profileController.getProfile();
            },
            icon: Icon(Icons.refresh_outlined),
            iconSize: getMediaQueryWidth(context, 0.07),
          ),
        ],
      ),
    );
  }

  Widget profileImage() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: getMediaQueryWidth(context, 0.18),
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: SizedBox(
                  width: getMediaQueryWidth(context, 0.6),
                  height: getMediaQueryWidth(context, 0.6),
                  child: profileController.profileImageFile.value.path != ""
                      ? Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(profileController.profileImageFile.value),
                              )))
                      : profileController.imgUrl.value != ""
                          ? profileController.isImageLoaded.value
                              ? Image.network(
                                  profileController.imgUrl.value,
                                  fit: BoxFit.fill,
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage('assets/images/account_profile.png'),
                                      )))
                          : Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/images/account_profile.png'),
                                  )))),
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.only(
                left: getMediaQueryWidth(context, 0.22),
                top: getMediaQueryHeight(context, 0.105),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.indigo,
                radius: getMediaQueryWidth(context, 0.05),
                child: IconButton(
                  iconSize: getMediaQueryWidth(context, 0.07),
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.edit),
                  color: Colors.white,
                  onPressed: () {
                    showCameraRequestPermissionBottomSheet(context);
                  },
                ),
              ),
            ))
      ],
    );
  }

  Future<PICK_IMAGE?> showCameraRequestPermissionBottomSheet(BuildContext context) async {
    double mqH = context.mediaQuery.size.height;
    double mqW = context.mediaQuery.size.width;
    PICK_IMAGE? mode;
    await showModalBottomSheet(
      context: context,
      // anchorPoint: Offset(0, 2),
      // enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (context) {
        return SizedBox(
          height: mqH * 0.15,
          child: Column(
            children: [
              ListTile(
                visualDensity: VisualDensity.comfortable,
                leading: Icon(Icons.camera_alt, size: mqW * 0.06),
                title: Text(
                  'Take a picture',
                  style: TextStyle(fontSize: mqW * 0.05),
                ),
                onTap: () async {
                  mode = PICK_IMAGE.CAMERA;
                  Get.back();
                  return;
                },
              ),
              ListTile(
                leading: Icon(Icons.image, size: mqW * 0.06),
                title: Text('Choose from gallery', style: TextStyle(fontSize: mqW * 0.05)),
                onTap: () async {
                  mode = PICK_IMAGE.GALLERY;
                  Get.back();
                  return;
                },
              ),
            ],
          ),
        );
      },
    );
    return mode;
  }

  Widget changeProfilePhoto() {
    return Container(
      margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.02)),
      child: Text(
        "Change profile photo",
        style: TextStyle(
            fontSize: getMediaQueryWidth(context, 0.05), color: Colors.blueAccent, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget employeeCode() {
    return Container(
      margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.02)),
      child: Text(
        profileController.userModel.value.employeeCode ?? "",
        style: TextStyle(fontSize: getMediaQueryWidth(context, 0.05), color: Colors.grey, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget userDetailsWidget() {
    return Container(
      margin: EdgeInsets.only(
          top: getMediaQueryHeight(context, 0.03),
          left: getMediaQueryWidth(context, 0.05),
          right: getMediaQueryWidth(context, 0.05)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("First Name",
                      style: TextStyle(
                          fontSize: getMediaQueryWidth(context, 0.04),
                          color: Colors.grey,
                          fontWeight: FontWeight.normal)),
                  TextField(
                    style: TextStyle(fontSize: getMediaQueryWidth(context, 0.04)),
                    controller: profileController.firstNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: (String keyword) {},
                  ),
                ],
              )),
              SizedBox(
                width: 20,
              ),
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Last Name",
                      style: TextStyle(
                          fontSize: getMediaQueryWidth(context, 0.04),
                          color: Colors.grey,
                          fontWeight: FontWeight.normal)),
                  TextField(
                    style: TextStyle(fontSize: getMediaQueryWidth(context, 0.04)),
                    controller: profileController.lastNameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: (String keyword) {},
                  ),
                ],
              ))
            ],
          ),
          SizedBox(
            height: getMediaQueryHeight(context, 0.03),
          ),
          Text("Mobile Number",
              style: TextStyle(
                  fontSize: getMediaQueryWidth(context, 0.04), color: Colors.grey, fontWeight: FontWeight.normal)),
          TextField(
            controller: profileController.mobileController,
            style: TextStyle(fontSize: getMediaQueryWidth(context, 0.04)),
            // enabled: false,
            readOnly: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            onChanged: (String keyword) {},
          ),
          SizedBox(
            height: getMediaQueryHeight(context, 0.03),
          ),
        ],
      ),
    );
  }

  Widget buttonView() {
    return Container(
      margin: EdgeInsets.only(
          top: getMediaQueryHeight(context, 0.05),
          left: getMediaQueryWidth(context, 0.05),
          right: getMediaQueryWidth(context, 0.05)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
              onPressed: () async {
                Get.back(result: [
                  {'backValue': 'true'}
                ]);
              },
              child: Text("Cancel",
                  style: TextStyle(
                      fontSize: getMediaQueryWidth(context, 0.040),
                      color: Colors.black,
                      fontWeight: FontWeight.normal)),
            ),
          ),
          SizedBox(
            width: getMediaQueryWidth(context, 0.1),
          ),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  )),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
              onPressed: () async {
                Utils.checkNetworkStatus().then((value) {
                  if (value) {
                    profileController.updateProfileName();
                  } else {
                    Utils.showAlertDialog(AppConstant.networkNotConnected);
                  }
                });
              },
              child: Text("Save",
                  style: TextStyle(
                      fontSize: getMediaQueryWidth(context, 0.040),
                      color: Colors.white,
                      fontWeight: FontWeight.normal)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source, imageQuality: 60);
    if (pickedImage != null) {
      profileController.profileImageFile.value = File(pickedImage.path);
      profileController.updateProfilePicture();
    }
  }

  Widget logOutButton() {
    return Container(
      margin: EdgeInsets.only(top: getMediaQueryHeight(context, 0.05)),
      child: SizedBox(
        width: getMediaQueryWidth(context, 0.5),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent)),
            onPressed: () async {
              await sessionManager.logOut();
            },
            child: Text("logout")),
      ),
    );
  }

  versionInfo() => Text("${ApiConstant.currentEnv} ${profileController.currentVersion.value}",
      style:
          TextStyle(fontSize: getMediaQueryWidth(context, 0.045), color: Colors.grey, fontWeight: FontWeight.normal));
}
