import 'package:asteroids/game.dart';
import 'package:asteroids/ui/game_over_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: AsteroidsGame(),
      loadingBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      overlayBuilderMap: {
        'GameOver': (BuildContext context, AsteroidsGame game) =>
            GameOverOverlay(game: game),
      },
    ),
  );
}
