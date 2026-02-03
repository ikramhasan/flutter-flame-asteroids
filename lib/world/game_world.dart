import 'package:asteroids/entities/ship.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/world/enemy_spawner.dart';
import 'package:asteroids/world/meteor_spawner.dart';
import 'package:asteroids/world/upgrade_spawner.dart';
import 'package:flame/components.dart';

/// Root world containing the player and enemy spawners.
class GameWorld extends World with HasGameReference<AsteroidsGame> {
  GameWorld({required this.shipAsset});

  final String shipAsset;

  @override
  Future<void> onLoad() async {
    final center = game.camera.visibleWorldRect.center;
    add(Ship(position: Vector2(center.dx, center.dy), spriteAsset: shipAsset));
    add(MeteorSpawner());
    add(EnemySpawner());
    add(UpgradeSpawner());
  }
}
