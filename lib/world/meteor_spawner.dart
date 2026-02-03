import 'dart:math';

import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/entities/meteor.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:flame/components.dart';

/// Spawns meteors just outside the visible bounds.
class MeteorSpawner extends Component with HasGameReference<AsteroidsGame> {
  static final _random = Random();

  double _timeSinceLastSpawn = 0;

  @override
  void update(double dt) {
    super.update(dt);

    _timeSinceLastSpawn += dt;
    if (_timeSinceLastSpawn >= GameTuning.meteorSpawnInterval) {
      _spawnMeteor();
      _timeSinceLastSpawn = 0;
    }
  }

  void _spawnMeteor() {
    final visibleRect = game.camera.visibleWorldRect;
    final meteorSize =
        GameTuning.meteorLargeSpawnMinSize +
        _random.nextDouble() * GameTuning.meteorLargeSpawnSizeRange;

    final edge = _random.nextInt(4);
    final spawnMargin = GameTuning.meteorSpawnMargin;
    late final Vector2 spawnPosition;
    late final Vector2 velocity;

    switch (edge) {
      case 0:
        spawnPosition = Vector2(
          visibleRect.left + _random.nextDouble() * visibleRect.width,
          visibleRect.top - spawnMargin,
        );
        velocity = Vector2(
          (_random.nextDouble() - 0.5) * 100,
          GameTuning.meteorMinSpeed +
              _random.nextDouble() *
                  (GameTuning.meteorMaxSpeed - GameTuning.meteorMinSpeed),
        );
        break;
      case 1:
        spawnPosition = Vector2(
          visibleRect.left + _random.nextDouble() * visibleRect.width,
          visibleRect.bottom + spawnMargin,
        );
        velocity = Vector2(
          (_random.nextDouble() - 0.5) * 100,
          -(GameTuning.meteorMinSpeed +
              _random.nextDouble() *
                  (GameTuning.meteorMaxSpeed - GameTuning.meteorMinSpeed)),
        );
        break;
      case 2:
        spawnPosition = Vector2(
          visibleRect.left - spawnMargin,
          visibleRect.top + _random.nextDouble() * visibleRect.height,
        );
        velocity = Vector2(
          GameTuning.meteorMinSpeed +
              _random.nextDouble() *
                  (GameTuning.meteorMaxSpeed - GameTuning.meteorMinSpeed),
          (_random.nextDouble() - 0.5) * 100,
        );
        break;
      default:
        spawnPosition = Vector2(
          visibleRect.right + spawnMargin,
          visibleRect.top + _random.nextDouble() * visibleRect.height,
        );
        velocity = Vector2(
          -(GameTuning.meteorMinSpeed +
              _random.nextDouble() *
                  (GameTuning.meteorMaxSpeed - GameTuning.meteorMinSpeed)),
          (_random.nextDouble() - 0.5) * 100,
        );
        break;
    }

    parent?.add(
      Meteor(
        position: spawnPosition,
        velocity: velocity,
        meteorSize: MeteorSize.large,
        size: meteorSize,
      ),
    );
  }
}
