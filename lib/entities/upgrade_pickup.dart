import 'dart:math';

import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/entities/ship.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Collectible that upgrades the ship's weapons.
class UpgradePickup extends SpriteComponent
    with CollisionCallbacks, HasGameReference<AsteroidsGame> {
  UpgradePickup({required super.position})
      : super(
          size: Vector2.all(32),
          anchor: Anchor.center,
        );

  double _pulseTime = 0;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(GameAssets.upgradeIcon);
    paint = Paint()
      ..colorFilter =
          const ColorFilter.mode(Colors.greenAccent, BlendMode.modulate);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    _pulseTime += dt;
    final pulse = 1 + sin(_pulseTime * 4) * 0.06;
    scale = Vector2.all(pulse);
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Ship) {
      game.stateManager.applyUpgrade();
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}
