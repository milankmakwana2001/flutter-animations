// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animation_one/second_screen/half_circle_clipper.dart';
import 'dart:math' show pi;

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with TickerProviderStateMixin {
  late AnimationController counterClockwiseRotationController;
  late Animation<double> counterClockwiseRotationAnimation;

  late AnimationController flipRotationController;
  late Animation<double> flipRotationAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );
    counterClockwiseRotationAnimation =
        Tween<double>(begin: 0, end: -(pi / 2)).animate(
      CurvedAnimation(
        parent: counterClockwiseRotationController,
        curve: Curves.bounceOut,
      ),
    );

    flipRotationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 2,
      ),
    );
    flipRotationAnimation = Tween<double>(
      begin: 0,
      end: pi,
    ).animate(
      CurvedAnimation(
        parent: flipRotationController,
        curve: Curves.bounceOut,
      ),
    );

    counterClockwiseRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        flipRotationAnimation = Tween<double>(
          begin: flipRotationAnimation.value,
          end: flipRotationAnimation.value + pi,
        ).animate(
          CurvedAnimation(
            parent: flipRotationController,
            curve: Curves.bounceOut,
          ),
        );
        flipRotationController
          ..reset()
          ..forward();
      }
    });

    flipRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        counterClockwiseRotationAnimation = Tween<double>(
          begin: counterClockwiseRotationAnimation.value,
          end: counterClockwiseRotationAnimation.value + -(pi / 2.0),
        ).animate(
          CurvedAnimation(
            parent: counterClockwiseRotationController,
            curve: Curves.bounceOut,
          ),
        );
        counterClockwiseRotationController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    counterClockwiseRotationController
      ..reset()
      ..forward();
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: counterClockwiseRotationAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateZ(counterClockwiseRotationAnimation.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: flipRotationAnimation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()
                          ..rotateY(
                            flipRotationAnimation.value,
                          ),
                        child: ClipPath(
                          clipper: HalfCircleClipper(
                            circleSide: CircleSide.LEFT,
                          ),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.blueAccent,
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: flipRotationAnimation,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..rotateY(flipRotationAnimation.value),
                        child: ClipPath(
                          clipper:
                              HalfCircleClipper(circleSide: CircleSide.RIGHT),
                          child: Container(
                            height: 100,
                            width: 100,
                            color: Colors.greenAccent,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
