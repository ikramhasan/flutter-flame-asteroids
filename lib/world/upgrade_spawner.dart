import 'dart:math';

import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/entities/upgrade_pickup.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:flame/components.dart';

/// Spawns weapon upgrade pickups while upgrades remain.
class UpgradeSpawner extends Component with HasGameReference<AsteroidsGame> {
  static final _random = Random();

  double _timeSinceLastSpawn = 0;

  @override
  void update(double dt) {
    super.update(dt);

    if (!game.stateManager.canSpawnUpgrade) {
      return;
    }

    _timeSinceLastSpawn += dt;
    if (_timeSinceLastSpawn >= GameTuning.upgradeSpawnInterval) {
      _spawnUpgrade();
      _timeSinceLastSpawn = 0;
    }
  }

  void _spawnUpgrade() {
    if (parent == null || parent!.children.query<UpgradePickup>().isNotEmpty) {
      return;
    }

    final visibleRect = game.camera.visibleWorldRect;
    final padding = GameTuning.upgradeSpawnPadding;

    final x = visibleRect.left + padding +
        _random.nextDouble() * (visibleRect.width - padding * 2);
    final y = visibleRect.top + padding +
        _random.nextDouble() * (visibleRect.height - padding * 2);

    parent?.add(UpgradePickup(position: Vector2(x, y)));
  }
}
