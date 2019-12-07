import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GameState();
}

class _GameState extends State<GameScreen> {
  int state = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: Text("")),
          Expanded(
            child: Text("You are Playing Snake!!"),
          ),
        ],
      ),
    );
  }
}
