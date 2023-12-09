import 'package:flutter/material.dart';

class AssetPng extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? size;

  const AssetPng({
    Key? key,
    required this.imagePath,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/png/$imagePath.png',
      color: color,
      width: size,
      height: size,
    );
  }
}
