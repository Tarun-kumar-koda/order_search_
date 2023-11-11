import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  InfoWidget({
    Key? key,
    required this.textWidget,
    this.infoTextStyle = const TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: Colors.black38,
    ),
    required this.iconData,
    required this.iconColor,
    this.elevation = 6,
  }) : super(key: key);

  final Widget textWidget;
  final TextStyle infoTextStyle;
  final IconData iconData;
  final Color iconColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      key: UniqueKey(),
      // offset: Offset(0, 1),
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      splashRadius: 0,
      surfaceTintColor: Colors.transparent,
      padding: const EdgeInsets.all(0),
      elevation: elevation,
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
              BoxShadow(offset: Offset(3, 3), spreadRadius: 1, blurRadius: 6, color: Colors.grey.shade400),
            ]),
            // color: Colors.green,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              child: GestureDetector(
                onPanUpdate: (pos) {
                  print(pos.globalPosition);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF7F7F7),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: textWidget,
                ),
              ),
            ),
          ),
        ),
      ],
      onSelected: (value) {},
      position: PopupMenuPosition.over,
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }
}
