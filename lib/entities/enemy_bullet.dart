import 'dart:math';

import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/entities/ship.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/utils/viewport_bounds.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Projectile fired by enemies.
class EnemyBullet extends SpriteComponent
    with CollisionCallbacks, HasGameReference<AsteroidsGame> {
  EnemyBullet({
    required super.position,
    required this.direction,
    this.speed = GameTuning.enemyBulletSpeed,
  }) : super(
          size: Vector2.all(GameTuning.bulletSize),
          anchor: Anchor.center,
        );

  /// Direction in radians.
  final double direction;

  /// Speed in pixels per second.
  final double speed;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(GameAssets.bullet);
    paint = Paint()
      ..colorFilter = const ColorFilter.mode(Colors.redAccent, BlendMode.modulate);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += sin(direction) * speed * dt;
    position.y -= cos(direction) * speed * dt;

    final bounds = ViewportBounds(game.camera.visibleWorldRect);
    if (bounds.isOutsidePosition(
      position,
      margin: GameTuning.bulletOffscreenMargin,
    )) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Ship) {
      game.stateManager.triggerGameOver(reason: 'You were shot down!');
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
