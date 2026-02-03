import 'dart:math';

import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/utils/viewport_bounds.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Projectile fired by the player.
class Bullet extends SpriteComponent with HasGameReference<AsteroidsGame> {
  Bullet({
    required super.position,
    required this.direction,
    this.speed = GameTuning.bulletSpeed,
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
}
