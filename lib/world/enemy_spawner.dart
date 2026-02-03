import 'dart:math';

import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/entities/enemy_ship.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:flame/components.dart';

/// Spawns enemy ships with progressive level unlocks.
class EnemySpawner extends Component with HasGameReference<AsteroidsGame> {
  static final _random = Random();

  double _timeSinceLastSpawn = 0;

  @override
  void update(double dt) {
    super.update(dt);

    if (game.stateManager.upgradeLevel < 1) {
      return;
    }

    _timeSinceLastSpawn += dt;
    if (_timeSinceLastSpawn >= GameTuning.enemySpawnInterval) {
      _spawnEnemy();
      _timeSinceLastSpawn = 0;
    }
  }

  void _spawnEnemy() {
    final visibleRect = game.camera.visibleWorldRect;
    final spawnMargin = GameTuning.enemySpawnMargin;

    final edge = _random.nextInt(4);
    late final Vector2 spawnPosition;

    switch (edge) {
      case 0:
        spawnPosition = Vector2(
          visibleRect.left + _random.nextDouble() * visibleRect.width,
          visibleRect.top - spawnMargin,
        );
        break;
      case 1:
        spawnPosition = Vector2(
          visibleRect.left + _random.nextDouble() * visibleRect.width,
          visibleRect.bottom + spawnMargin,
        );
        break;
      case 2:
        spawnPosition = Vector2(
          visibleRect.left - spawnMargin,
          visibleRect.top + _random.nextDouble() * visibleRect.height,
        );
        break;
      default:
        spawnPosition = Vector2(
          visibleRect.right + spawnMargin,
          visibleRect.top + _random.nextDouble() * visibleRect.height,
        );
        break;
    }

    final maxLevel = game.stateManager.unlockedEnemyLevel;
    final level = 1 + _random.nextInt(maxLevel);

    parent?.add(EnemyShip(position: spawnPosition, level: level));
  }
}
