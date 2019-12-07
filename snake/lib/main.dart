import 'package:flutter/material.dart';
import 'gamescreen.dart';

void main() => runApp(MySnakeGameHome());

class MySnakeGameHome extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/play': (context) => GameScreen(),
      }
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(child: Text("")),
          Expanded(
            child: Text("Snake!!"),
          ),
          Expanded(
            child: Text(""),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/play');
              },
              child: Container(
                height: 11.0,
                padding: const EdgeInsets.all(1.0),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000.0),
                    color: Colors.lightGreen[500]),
                child: Center(child: Text("PLAY")),
              ),
            ),
          ),
          Expanded(child: Text(""))
        ],
      ),
    );
  }
}
/*
Row(
        children: <Widget>[
          Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                      height: 36.0,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.lightGreen[500]
                      ),
                      child: Center(
                          child: Text("Play")
                      ),
                    )
                )
              ]
          )
        ]
    );
  }
 */
