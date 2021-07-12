import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box({required this.height, required this.width, Key? key})
      : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: Colors.amber,
    );
  }
}
