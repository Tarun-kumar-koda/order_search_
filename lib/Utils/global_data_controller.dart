import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/services/session_manager.dart';

class GlobalController extends GetxController {
  SessionManager sessionManager = SessionManager();

  @override
  void onInit() {
    print("onInit");
  }

  @override
  void onReady() async {
    print(Get.currentRoute);
  }

  @override
  void pageReload() {}

  @override
  void onClose() {}

  @override
  void dispose() {
    super.dispose();
  }
}

abstract class Route {
  int routeId = 123;

  myMethod();
}
//
// class NavRoute with Route{
//   String routeName;
//   String address;
//   int val;
//
//   NavRoute(this.routeName,  this.address, this.val);
//
//   NavRoute.global(this.routeName, this.address, this.val);
//
//   factory NavRoute.logic(){
//     return NavRoute(
//       "das","as",2
//     );
//   }
//
//   myMethod(){
//     print("bla");
//   }
// }
// class CompleteNavRoute extends NavRoute{
//   int id = 0;
//
//   CompleteNavRoute(routeName,address,val) : super(routeName, address, val);
//
// }

void main() {
  // CompleteNavRoute cnr = CompleteNavRoute("RTADJDAJK","asdasdsad",12);
  // print(cnr.routeName);

  // Route r = NavRoute("routeName", "address", 1);
  // r.myMethod();
  // print(r.routeId);

  runApp(GetMaterialApp(
    home: Scaffold(
        body: Container(
      child: Center(
        child: Column(
          children: [
            Text("welcome".capitalizeFirst ?? ""),
            ElevatedButton(onPressed:()=> Get.showOverlay(asyncFunction: () async {},), child: Text("press"))
          ],
        ),
      ),
    )),
  ));
  GlobalController gc = Get.put(GlobalController());
  gc.onReady();
  Get.log("Route data cleared ",isError: true);

}
