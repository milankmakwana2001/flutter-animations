// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_animation_one/third_screen/third_screen.dart';

class ThirdDetails extends StatefulWidget {
  final Person person;

  ThirdDetails({Key? key, required this.person}) : super(key: key);

  @override
  State<ThirdDetails> createState() => _ThirdDetailsState();
}

class _ThirdDetailsState extends State<ThirdDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: widget.person.name,
          flightShuttleBuilder: (
            flightContext,
            animation,
            flightDirection,
            fromHeroContext,
            toHeroContext,
          ) {
            switch (flightDirection) {
              case HeroFlightDirection.push:
                return ScaleTransition(
                  scale: animation.drive(
                    Tween<double>(
                      begin: 0,
                      end: 1.0,
                    ).chain(
                      CurveTween(
                        curve: Curves.linearToEaseOut,
                      ),
                    ),
                  ),
                  child: toHeroContext.widget,
                );
              case HeroFlightDirection.pop:
                return fromHeroContext.widget;
            }
          },
          child: Material(
            color: Colors.transparent,
            child: Text(
              widget.person.emoji,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(widget.person.name),
            Text(
              '${widget.person.age} years old',
            ),
          ],
        ),
      ),
    );
  }
}
