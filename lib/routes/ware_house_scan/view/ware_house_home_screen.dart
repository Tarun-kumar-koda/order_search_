import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/Utils/utils.dart';
import 'package:order_search/constant/app_constant.dart';
import 'package:order_search/my_app.dart';
import 'package:order_search/routes/base_route.dart';
import 'package:order_search/routes/ware_house_scan/view/pod_images_widget.dart';
import 'package:order_search/services/session_manager.dart';
import 'package:order_search/widgets/pod_images_widget/file_manager.dart';
import 'package:order_search/widgets/toolbar/toolbar_view.dart';
import '../../../model/global_search_order.dart';
import '../../../realm/order_picture.dart';
import '../controller/scan_ware_house_controller.dart';

class ScannedOrderListView extends StatefulWidget {
  const ScannedOrderListView({Key? key}) : super(key: key);

  @override
  State<ScannedOrderListView> createState() => _ScannedOrderListViewState();
}

class _ScannedOrderListViewState extends BaseRoute<ScannedOrderListView> with WidgetsBindingObserver {

  WareHouseHomeController homeController = Get.put(WareHouseHomeController());
  SessionManager sessionManager = Get.put(SessionManager());
  var showLoadButton = true;
  var showCrossDockButton = true;
  static GlobalKey homeKey = GlobalKey();
  String textFieldValueChanging = "";
  late String truck;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    truck = "";
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: homeKey,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
            child: Column(
          children: [
            const ToolBarView(),
            SizedBox(
              height: getMediaQueryHeight(context, 0.001),
            ),
            // Container(
            //   color: const Color(0xFFE0E0E0),
            //   width: getMediaQueryWidth(context, 1),
            //   height: 1.5,
            // ),
            Container(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
              width: getMediaQueryWidth(context, 1),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(getMediaQueryWidth(context, 0.03)),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 3),
                          blurRadius: 3,
                          spreadRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Container(
                          child: showWarehouseList(),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getMediaQueryHeight(context, 0.01),
            ),
            Expanded(
              child: Obx(() => searchOrderListWidget(context)),
            ),
            // ElevatedButton(onPressed: (){
            //   showCameraRequestPermissionBottomSheet(context);
            // }, child: Text("permission"))
          ],
        )),
      ),
    );
  }

  Widget showWarehouseList() {
    return Column(
      children: [
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: homeController.formKey,
          child: Column(
            children: [
              SizedBox(
                width: getMediaQueryWidth(context, 0.9),
                child: homeController.isApiCompleted.value && homeController.whLocList.isEmpty ? Container(
                  padding: EdgeInsets.all(getMediaQueryWidth(context, 0.03)),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey
                      ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      homeController.getWarehouseList();
                    },
                    child: const Text("Tap to fetch warehouses", style: TextStyle(color: Colors.black, fontSize: 15, overflow: TextOverflow.fade)),
                  )
                ) : DropdownButtonFormField2(
                  disabledHint: RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                      children: <TextSpan>[
                        TextSpan(text: "Choose a Warehouse", style: TextStyle(color: Colors.grey, fontSize: 15)),
                      ],
                    ),
                  ),
                  isDense: true,
                  // customButton: SizedBox(height: 30,child: ElevatedButton(child: Text("press"),onPressed: (){})),
                  value: null,
                  enableFeedback: true,
                  isExpanded: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                    contentPadding: const EdgeInsets.only(right: 5),
                    errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.indigo), borderRadius: BorderRadius.circular(10)),
                    focusColor: Colors.indigo,
                    isDense: true,
                  ),
                  barrierDismissible: true,
                  hint: SizedBox(
                    width: getMediaQueryWidth(context, 0.5),
                    child: const Text(
                      'Choose a Warehouse',
                      style: TextStyle(color: Colors.grey, fontSize: 14, overflow: TextOverflow.fade),
                    ),
                  ),
                  items: homeController.whLocList
                      .map(
                        (data) => DropdownMenuItem(
                      value: data,
                      child: data.id == null
                          ? RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(text: data.name, style: const TextStyle(overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          )
                          : RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: data.name, style: const TextStyle(overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          ),
                    ),
                  )
                      .toList(),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    offset: const Offset(0, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all<double>(6),
                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                    ),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: EdgeInsets.only(left: getMediaQueryWidth(context, 0.05)),
                  ),
                  validator: (value) {
                    if (value?.id == null) {
                      return 'Please select any warehouse to search';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    homeController.selectedWarehouse = value!;
                  },
                  onSaved: (value) {},
                  buttonStyleData: ButtonStyleData(
                    height: getMediaQueryHeight(context, 0.05),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(context, 0.013),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        SizedBox(
            width: getMediaQueryWidth(context, 0.85),
            child: TextField(
                cursorColor: Utils.hexColor(AppColor.appPrimaryColor),
                controller: homeController.selectFilterController,
                maxLines: 1,
                style: TextStyle(color: Colors.black, fontSize: getMediaQueryWidth(context, 0.05)),
                onChanged: (v) {
                  setState(() {
                    textFieldValueChanging = v;
                  });
                },
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  if (homeController.selectFilterController.text.isNotEmpty) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Utils.checkNetworkStatus().then((value) {
                      if (value) {
                        homeController.getOrderData(homeController.selectFilterController.text,homeController.selectedWarehouse.id!);
                      } else {
                        Utils.showAlertDialog(AppConstant.networkNotConnected);
                      }
                    });
                  } else {
                    Utils.checkNetworkStatus().then((value) {
                      if (value) {
                        Utils.showAlertDialog("The search field is empty. Please enter a value.");
                      } else {
                        Utils.showAlertDialog(AppConstant.networkNotConnected);
                      }
                    });
                  }
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1.5, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 1.5, color: Utils.hexColor(AppColor.appPrimaryColor)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                        homeController.orderList.clear();
                        homeController.orderList.refresh();
                      homeController.selectFilterController.text = "";
                    },
                    icon: Icon(
                      Icons.close_sharp,
                      size: 20,
                      color: textFieldValueChanging.isNotEmpty ? Colors.black : Colors.grey,
                    ),
                  ),
                  filled: true,
                  isDense: true,
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Search",
                  contentPadding: EdgeInsets.only(left: getMediaQueryWidth(context, 0.03)),
                ))),
          ],
        ),
        Container(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: getMediaQueryWidth(context, 0.28),
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                                top: getMediaQueryHeight(context, 0.009),
                                bottom: getMediaQueryHeight(context, 0.009),
                                left: getMediaQueryWidth(context, 0.02),
                                right: getMediaQueryWidth(context, 0.02))),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo)),
                        onPressed: () async {
                          if(homeController.formKey.currentState!.validate()){
                          if (homeController.selectFilterController.text.isNotEmpty) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            Utils.checkNetworkStatus().then((value) {
                              if (value) {
                                homeController.orderList.clear();
                                homeController.orderList.refresh();
                                homeController.sessionManager.realm.write(() {
                                  homeController.sessionManager.realm.deleteAll<OrderPicture>();
                                });
                                homeController.getOrderData(homeController.selectFilterController.text,homeController.selectedWarehouse.id!);
                              } else {
                                Utils.showAlertDialog(AppConstant.networkNotConnected);
                              }
                            });
                          } else {
                            Utils.checkNetworkStatus().then((value) {
                              if (value) {
                                Utils.showAlertDialog("The search field is empty. Please enter a value.");
                              } else {
                                Utils.showAlertDialog(AppConstant.networkNotConnected);
                              }
                            });
                          }
                          }
                        },
                        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          Text(
                            "Search",
                            style: TextStyle(color: Colors.white, fontSize: getMediaQueryWidth(context, 0.05)),
                          )
                        ]))),
              ],
            )),
      ],
    );
  }

  Widget searchOrderListWidget(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 5.0, top: 8),
        child: homeController.orderList.isNotEmpty
            ? Scrollbar(
                thumbVisibility: false,
                thickness: 4,
                radius: const Radius.circular(10.0),
                child: ListView.builder(
                    itemCount: homeController.orderList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        _getListWidgets(homeController.orderList[index], index, context)),
              )
            : Center(
                child: Container(child: _emptyListText()),
              ));
  }

  Widget _emptyListText() {
    return const Text("No Records Found", style: TextStyle(color: Colors.grey, fontSize: 15, overflow: TextOverflow.fade));
  }

  Widget _getListWidgets(CustomerOrders ordersModel, int index, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(right: 5),
          child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 2,
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: getMediaQueryWidth(context, 0.95),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "#${Utils.getTextValue(ordersModel.order?.customerOrderNumber ?? "")}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontSize: getMediaQueryWidth(context, 0.05),
                                          color: Utils.hexColor(AppColor.appPrimaryColor),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          homeController.orderList.removeAt(index);
                                          homeController.orderList.refresh();
                                        },
                                        icon: const Icon(Icons.cancel_outlined))
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 1.2,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    child: tableView(ordersModel.order!, index, context),
                  ),
                ],
              )),
        ),
      ],
    );
  }

  Widget tableView(Order ordersModel, int index, BuildContext context) {
    OrderPicture? pictureObj;
    pictureObj = sessionManager.realm
        .query<OrderPicture>("orderNumber == '${ordersModel.customerOrderNumber ?? ""}'")
        .firstOrNull;

    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFE0E0E0),
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
      child: Row(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: getMediaQueryHeight(context, 0.55),
              padding: EdgeInsets.only(
                left: getMediaQueryWidth(context, 0.025),
              ),
              width: getMediaQueryWidth(context, 0.95),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.25),
                        child: Text("${AppConstant.filter_hawb}:",
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: getMediaQueryWidth(context, 0.035))),
                      ),
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.5),
                        child: Text(Utils.getTextValue(ordersModel.hawb),
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getMediaQueryWidth(context, 0.035))),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.25),
                        child: Text("${AppConstant.filter_mawab}:",
                            style:
                                TextStyle(fontWeight: FontWeight.bold, fontSize: getMediaQueryWidth(context, 0.035))),
                      ),
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.5),
                        child: Text(Utils.getTextValue(ordersModel.mawb),
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getMediaQueryWidth(context, 0.035))),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.25),
                        child: Text("Account:",
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: getMediaQueryWidth(context, 0.035))),
                      ),
                      SizedBox(
                          width: getMediaQueryWidth(context, 0.5),
                          child: Text(Utils.getTextValue(ordersModel.accountName).toUpperCase(),
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: getMediaQueryWidth(context, 0.035))))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.25),
                        child: Text("Customer Name",
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: getMediaQueryWidth(context, 0.035))),
                      ),
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.5),
                        child: Text(Utils.getTextValue(ordersModel.customerFirstName.toString()),
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getMediaQueryWidth(context, 0.035))),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.25),
                        child: Text("Company Name",
                            style:
                                TextStyle(fontWeight: FontWeight.w500, fontSize: getMediaQueryWidth(context, 0.035))),
                      ),
                      SizedBox(
                        width: getMediaQueryWidth(context, 0.5),
                        child: Text(Utils.getTextValue(ordersModel.companyName.toString()),
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getMediaQueryWidth(context, 0.035))),
                      )
                    ],
                  ),
                  PodImagesWidget(key: Key(ordersModel.id!),orderDetails: ordersModel, parentKey: homeKey,widgetIndex: index,),
                  // PodImagesWidget(orderDetails: ordersModel, parentKey: homeKey, customerOrders: customerOrders),

                  // ElevatedButton(onPressed: (){
                  //   OrderPicture? op = sessionManager.realm.query<OrderPicture>("orderNumber == '${homeController.orderList.first.orderNumber}'").firstOrNull;
                  //   print(op?.localPath);
                  //   print(homeController.orderList.first.orderNumber);
                  //   List<OrderPicture> ordersP = sessionManager.realm.all<OrderPicture>().toList();
                  //   print(ordersP.map((e) => e.localPath));
                  //   setState(() {
                  //
                  //   });
                  //     }, child: Text("press")),

                  // SizedBox(
                  //     width: getMediaQueryWidth(context, 0.28),
                  //     child: ElevatedButton(
                  //         style: ButtonStyle(
                  //             padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(
                  //                 top: getMediaQueryHeight(context, 0.009),
                  //                 bottom: getMediaQueryHeight(context, 0.009),
                  //                 left: getMediaQueryWidth(context, 0.02),
                  //                 right: getMediaQueryWidth(context, 0.02))),
                  //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //             shape: MaterialStateProperty.all(
                  //                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  //             backgroundColor:
                  //             pictureObj != null ? MaterialStateProperty.all<Color>(Utils.hexColor(AppColor.appPrimaryColor)) : MaterialStateProperty.all<Color>(Colors.grey),
                  //         ),
                  //         onPressed: pictureObj != null ? () async {
                  //
                  //         } : null,
                  //         child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  //           Text(
                  //             "Upload",
                  //             style: TextStyle(color: Colors.white, fontSize: getMediaQueryWidth(context, 0.04)),
                  //           )
                  //         ]))),
                  // PodImagesWidget(orderDetails: ordersModel, parentKey: homeKey, customerOrders: customerOrders),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}
