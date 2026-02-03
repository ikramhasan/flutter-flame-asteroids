import 'dart:math';

import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/entities/bullet.dart';
import 'package:asteroids/entities/meteor.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/utils/viewport_bounds.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

/// Player-controlled ship.
class Ship extends PositionComponent
    with KeyboardHandler, CollisionCallbacks, HasGameReference<AsteroidsGame> {
  Ship({super.position, this.spriteAsset = GameAssets.ship})
      : super(
          size: Vector2.all(GameTuning.shipSize),
          anchor: Anchor.center,
        );

  /// Sprite asset to render for the ship.
  final String spriteAsset;

  double _timeSinceLastShot = 0;
  final Set<LogicalKeyboardKey> _keysPressed = {};
  late final SpriteComponent _thrusterEffect;
  late final SpriteComponent _shipSprite;

  @override
  Future<void> onLoad() async {
    _shipSprite = SpriteComponent(
      sprite: await Sprite.load(spriteAsset),
      size: size.clone(),
      anchor: Anchor.center,
      position: size / 2,
    );

    _thrusterEffect = SpriteComponent(
      sprite: await Sprite.load(GameAssets.thruster),
      size: Vector2(GameTuning.thrusterWidth, GameTuning.thrusterHeight),
      anchor: Anchor.topCenter,
      position: Vector2(size.x / 2, size.y - GameTuning.thrusterOffset),
    )..opacity = 0;

    _thrusterEffect.priority = -1;
    addAll([_thrusterEffect, _shipSprite, CircleHitbox()]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timeSinceLastShot += dt;

    final isThrusting =
        _keysPressed.contains(LogicalKeyboardKey.keyW) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowUp);
    _thrusterEffect.opacity = isThrusting ? 1 : 0;

    if (isThrusting) {
      position.x += sin(angle) * GameTuning.shipMoveSpeed * dt;
      position.y -= cos(angle) * GameTuning.shipMoveSpeed * dt;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyA) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      angle -= GameTuning.shipRotateSpeed * dt;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyD) ||
        _keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      angle += GameTuning.shipRotateSpeed * dt;
    }

    if ((_keysPressed.contains(LogicalKeyboardKey.space) ||
            _keysPressed.contains(LogicalKeyboardKey.controlLeft) ||
            _keysPressed.contains(LogicalKeyboardKey.controlRight)) &&
        _timeSinceLastShot >= GameTuning.shipShootCooldown) {
      _shoot();
      _timeSinceLastShot = 0;
    }

    final bounds = ViewportBounds(game.camera.visibleWorldRect);
    if (bounds.isOutsideComponent(this)) {
      game.stateManager
          .triggerGameOver(reason: 'You hit the screen boundary!');
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _keysPressed
      ..clear()
      ..addAll(keysPressed);
    return true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Meteor) {
      game.stateManager.triggerGameOver(reason: 'You crashed into a meteor!');
    }
    super.onCollision(intersectionPoints, other);
  }

  void _shoot() {
    final bulletOffset = Vector2(sin(angle), -cos(angle)) * (size.y / 2);
    final bulletPosition = position + bulletOffset;
    parent?.add(Bullet(position: bulletPosition, direction: angle));
  }
}
