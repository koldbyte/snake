import 'dart:math';

import 'package:flutter/material.dart';

class Position {
  int x;
  int y;
  Position(int x, int y) {
    this.x = x;
    this.y = y;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Position &&
              runtimeType == other.runtimeType &&
              x == other.x &&
              y == other.y;

  @override
  int get hashCode =>
      x.hashCode ^
      y.hashCode;

}

enum Direction {
  UP,
  DOWN,
  LEFT,
  RIGHT
}

class GameArena extends StatefulWidget {
  final int _MAX_WIDTH = 200;
  final int _MAX_HEIGHT = 200;

  @override
  State<StatefulWidget> createState() {
    return GameState(_MAX_HEIGHT, _MAX_WIDTH);
  }
}

class GameState extends State<GameArena> {
  int maxWidth;
  int maxHeight;
  Direction snakeDir = Direction.RIGHT;
  Position foodPosition = Position(10, 10);
  List<Position> snakeBodyPosition = <Position>[Position(0,0), Position(0,1)];

  GameState(int maxHeight, int maxWidth) {
    this.maxHeight = maxHeight;
    this.maxWidth = maxWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _build_grid()
    );
  }

  Widget _build_grid() {
    List<Row> rows = <Row>[];
    for (int i = 0; i < maxHeight; i++) {
      List<Column> cells = <Column>[];
      for (int j = 0; j < maxWidth; j++) {
        List<Widget> columnContent = <Widget>[];
        // Add food on top of the cell
        columnContent.add(Container(color: Colors.green,));
        if (foodPosition.x == i && foodPosition.y == j) {
          columnContent.add(Container(color: Colors.red,));
        }
        if (snakeBodyPosition.contains(Position(i, j))) {
          columnContent.add(Container(color: Colors.black,));
        }
        cells.add(Column(children: <Widget>[Stack(children: columnContent)]));
      }
      Row r = Row(children: cells);
      rows.add(r);
    }
    return Row(children: rows,);
  }

  /// Randomly generate a position in the grid, such that, snake body
  /// it is not same or it is
  Position _get_random_position() {
    if (snakeBodyPosition.length >= (maxWidth * maxHeight - 1)) return null;
    int y = Random.secure().nextInt(maxWidth);
    int x = Random.secure().nextInt(maxHeight);
    if (foodPosition.x == x && foodPosition.y == y) return _get_random_position();
    Position newPos = Position(x, y);
    if (snakeBodyPosition.contains(newPos)) return _get_random_position();
    return newPos;
  }

  void move_snake() {
    Position snakeHead = snakeBodyPosition.first;
    if (snakeHead == foodPosition) {
      Position nextFoodPosition = _get_random_position();
      if (nextFoodPosition == null) {
        print("Game Over! Player Wins! Score: " + snakeBodyPosition.length.toString());
        // Navigate to next screen
      }
      setState(() {
        snakeBodyPosition.add(foodPosition);
        foodPosition = nextFoodPosition;
      });
    } else if (!_is_inside_boundary(snakeHead)) {
      print("Game Over! Player Loses! Score: " + snakeBodyPosition.length.toString());
      // Navigate to next screen
    } else {
      Position newPos = get_next_position(snakeHead);
      setState(() {
        snakeBodyPosition.insert(0, newPos);
        snakeBodyPosition.removeLast();
      });
    }
  }

  bool _is_inside_boundary(Position snakeHeadPosition) {
    int x = snakeHeadPosition.x;
    int y = snakeHeadPosition.y;
    if (x > 0 || x <= -1*maxHeight) return false;
    if (y < 0 || y >= maxWidth) return false;
    return true;
  }

  Position get_next_position(Position snakeHeadPosition) {
    if (snakeDir == Direction.LEFT) return new Position(snakeHeadPosition.x - 1, snakeHeadPosition.y);
    else if (snakeDir == Direction.RIGHT) return new Position(snakeHeadPosition.x + 1, snakeHeadPosition.y);
    else if (snakeDir == Direction.UP) return new Position(snakeHeadPosition.x, snakeHeadPosition.y + 1);
    else return new Position(snakeHeadPosition.x, snakeHeadPosition.y - 1);
  }


}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          AppBar(title: Text('Eat them all!', style: Theme.of(context).primaryTextTheme.title)),
          Expanded(
            child: GameArena(),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'snake',
    home: MyScaffold(),
  ));
}