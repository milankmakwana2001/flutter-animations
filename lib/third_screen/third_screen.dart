// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_animation_one/third_screen/third_detais_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final List<Person> person = [
    Person(name: 'John', age: 18, emoji: '👨'),
    Person(name: 'Max', age: 19, emoji: '👨🏽'),
    Person(name: 'Rebe', age: 20, emoji: '👩'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final people = person[index];
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ThirdDetails(person: people),
                ),
              );
            },
            trailing: Icon(
              Icons.arrow_forward_ios,
            ),
            title: Text(
              people.name,
            ),
            subtitle: Text(
              '${people.age.toString()} years old',
            ),
            leading: Hero(
              tag: people.name,
              child: Material(
                child: Text(
                  people.emoji,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: person.length,
      ),
    );
  }
}

class Person {
  final String name;
  final int age;
  final String emoji;

  const Person({
    required this.name,
    required this.age,
    required this.emoji,
  });
}
