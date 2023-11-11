import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final String? msg;
  LoadingPage({this.msg,super.key});

  // RxString dots = "...".obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 20.0),
              //       child: Image.asset("assets/images/splash_logo.png",scale: 5),
              //     ),
              //   ],
              // ),
              Stack(
                children: [
                  Image.asset(
                    filterQuality: FilterQuality.high,
                    "assets/gifs/pod_loading_1.gif",
                    // colorBlendMode: BlendMode.clear,
                    scale: 1.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 82.0,left: 105),
                    child: Image.asset("assets/images/splash_logo.png",scale: 6,color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              msg != null ? Text(msg!,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 17)) :
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Refreshing route...",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.w400,fontSize: 20)),
                  SizedBox(height: 20,),
                  Text("please wait, while we are arranging things",style: TextStyle(color: Colors.indigo.shade400,fontWeight: FontWeight.w400,fontSize: 15)),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
