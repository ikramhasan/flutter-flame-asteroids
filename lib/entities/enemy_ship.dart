import 'dart:math';

import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/entities/bullet.dart';
import 'package:asteroids/entities/enemy_bullet.dart';
import 'package:asteroids/entities/ship.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/utils/viewport_bounds.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Enemy ship that chases the player and shoots.
class EnemyShip extends SpriteComponent
    with CollisionCallbacks, HasGameReference<AsteroidsGame> {
  EnemyShip({required super.position, required this.level})
      : _hitPoints = level,
        super(
          size: Vector2.all(GameTuning.enemySize),
          anchor: Anchor.center,
        );

  /// Enemy level (1-5). Higher levels have more health.
  final int level;

  int _hitPoints;
  double _timeSinceLastShot = 0;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(_spriteForLevel(level));
    paint = Paint()
      ..colorFilter = const ColorFilter.mode(Colors.redAccent, BlendMode.modulate);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timeSinceLastShot += dt;

    final ship = _playerShip;
    if (ship == null) {
      return;
    }

    final toPlayer = ship.position - position;
    if (toPlayer.length2 > 0.1) {
      final direction = toPlayer.normalized();
      position += direction * GameTuning.enemySpeed * dt;
      angle = atan2(direction.y, direction.x) + pi / 2;
    }

    if (_timeSinceLastShot >= GameTuning.enemyShootCooldown) {
      _shootAt(ship.position);
      _timeSinceLastShot = 0;
    }

    final bounds = ViewportBounds(game.camera.visibleWorldRect);
    if (bounds.isOutsidePosition(position, margin: GameTuning.enemyOffscreenMargin)) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Bullet) {
      other.removeFromParent();
      _hitPoints -= 1;
      if (_hitPoints <= 0) {
        removeFromParent();
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  Ship? get _playerShip {
    final ships = game.world.children.query<Ship>();
    return ships.isEmpty ? null : ships.first;
  }

  void _shootAt(Vector2 target) {
    final delta = target - position;
    if (delta.length2 <= 0.1) {
      return;
    }

    final direction = atan2(delta.y, delta.x) + pi / 2;
    final bulletOffset = Vector2(sin(direction), -cos(direction)) * (size.y / 2);
    parent?.add(
      EnemyBullet(
        position: position + bulletOffset,
        direction: direction,
      ),
    );
  }

  String _spriteForLevel(int level) {
    final index = (level - 1).clamp(0, GameAssets.enemyVariants.length - 1);
    return GameAssets.enemyVariants[index];
  }
}
