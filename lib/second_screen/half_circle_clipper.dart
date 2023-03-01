import 'package:flutter/material.dart';
import 'package:flutter_animation_one/second_screen/second_screen.dart';

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide circleSide;

  const HalfCircleClipper({
    required this.circleSide,
  });

  @override
  Path getClip(Size size) => circleSide.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offSet;
    late bool clockwise;

    switch (this) {
      case CircleSide.LEFT:
        //**This is starting point of the path**/
        path.moveTo(size.height, 0);

        //This is Destination point of the path//
        offSet = Offset(size.width, size.height);

        //Direction of the path//
        clockwise = false;
        break;

      case CircleSide.RIGHT:
        path.moveTo(0, 0);
        offSet = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(
      offSet,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }
}

enum CircleSide {
  LEFT,
  RIGHT,
}
