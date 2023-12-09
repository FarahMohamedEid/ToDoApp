import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AssetSvg extends StatelessWidget {
  final String imagePath;
  final Color? color;
  final double? size;

  const AssetSvg({
    Key? key,
    required this.imagePath,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svg/$imagePath.svg',
      color: color,
      width: size,
      height: size,
    );
  }
}
