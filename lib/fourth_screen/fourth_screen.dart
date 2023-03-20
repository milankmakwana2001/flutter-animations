// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Alignment> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
      ),
    );
    _animation = Tween<Alignment>(
      begin: Alignment.centerRight,
      end: Alignment.centerLeft,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.bounceIn,
      ),
    );
  }

  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Fourth'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              alignment: _animation.value,
              padding: EdgeInsets.all(2.6),
              height: 23,
              width: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: isEnabled ? Colors.green : Colors.grey,
              ),
              child: GestureDetector(
                onTap: () async {
                  if (isEnabled) {
                    await _controller.forward();
                    isEnabled = !isEnabled;
                  } else {
                    await _controller.reverse();
                    isEnabled = !isEnabled;
                  }

                  if(isEnabled){
                    HapticFeedback.heavyImpact();
                  }
                  print(isEnabled.toString());

                },
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  // child: isEnabled
                  //     ? Text(
                  //         'ON',
                  //         style: TextStyle(color: Colors.black),
                  //       )
                  //     : Text(
                  //         'OFF',
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
