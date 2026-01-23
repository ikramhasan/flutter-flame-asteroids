import 'package:asteroids/game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: AsteroidsGame(),
      loadingBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
    ),
  );
}
