import 'package:flutter/material.dart';

class SlideToast extends StatefulWidget {
  final Widget _child;
  final double x;
  final double y;


  SlideToast(this._child, {required this.x, required this.y});

  @override
  _SlideToastState createState() => _SlideToastState();
}

class _SlideToastState extends State<SlideToast> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetFloat;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _offsetFloat =
        Tween(begin: Offset(widget.x, widget.y), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.fastOutSlowIn,
          ),
        );

    _offsetFloat.addListener(() {
      setState(() {});
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetFloat,
      child: widget._child,
    );
  }
}

