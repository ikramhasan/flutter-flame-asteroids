import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/ui/game_over_overlay.dart';
import 'package:asteroids/ui/start_overlay.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: AsteroidsGame(),
      loadingBuilder: (context) =>
          const Center(child: CircularProgressIndicator()),
      overlayBuilderMap: {
        AsteroidsGame.overlayStart: (BuildContext context, AsteroidsGame game) =>
            StartOverlay(game: game),
        AsteroidsGame.overlayGameOver: (BuildContext context, AsteroidsGame game) =>
            GameOverOverlay(game: game),
      },
    ),
  );
}
