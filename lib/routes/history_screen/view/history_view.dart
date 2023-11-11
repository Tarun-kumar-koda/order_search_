// import 'package:fleet_enable/database/database_helper.dart';
// import 'package:fleet_enable/routes/history_screen/convertors/history_controller.dart';
// import 'package:fleet_enable/widgets/page_toolbar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HistoryView extends StatefulWidget {
//   @override
//   _HistoryViewState createState() => _HistoryViewState();
// }
//
// class _HistoryViewState extends State<HistoryView> {
//
//   HistoryController historyController = Get.put(HistoryController());
//
//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }
//
//   void getData()async{
//     await DatabaseHelper.createInstance().getNavRoute().then((value){
//       for(var s in value){
//         print(s.stops!.length);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: PageToolBar(title: "Routes",),
//       ),
//     );
//   }
// }
