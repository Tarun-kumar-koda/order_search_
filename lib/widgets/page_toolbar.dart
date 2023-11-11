import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:order_search/routes/base_route.dart';

class PageToolBar extends StatefulWidget {
  final title;

  const PageToolBar(
      {this.title});

  @override
  _PageToolBarState createState() => _PageToolBarState();
}

class _PageToolBarState extends BaseRoute<PageToolBar> {
  @override
  Widget build(BuildContext context) {
    return toolBar();
  }

  Widget toolBar(){
    return Container(
      margin: EdgeInsets.only(left: getMediaQueryHeight(context, 0.01),
          right: getMediaQueryHeight(context, 0.01), top: getMediaQueryHeight(context, 0.015)),
      child: Row(
        children: [
          IconButton(onPressed: (){ Get.back(); },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            iconSize: getMediaQueryWidth(context, 0.05),),
          Container(
            width: getMediaQueryWidth(context, 0.5),
            child:Text(widget.title ?? "",
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(fontSize: getMediaQueryWidth(context, 0.048), fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

}
