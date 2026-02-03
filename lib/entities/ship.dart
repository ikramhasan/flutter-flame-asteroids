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
  Vector2 _velocity = Vector2.zero();

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
      final thrust = Vector2(sin(angle), -cos(angle));
      _velocity += thrust * GameTuning.shipThrustAcceleration * dt;
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

    _applyMovement(dt);

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
    final level = game.stateManager.upgradeLevel;
    final fireCount = level == 0 ? 1 : (level == 1 ? 2 : 3);
    final spread = level >= 2 ? 0.18 : 0.12;

    game.sfx.play(GameAudio.shoot, volume: 0.5);

    if (fireCount == 1) {
      final bulletOffset = Vector2(sin(angle), -cos(angle)) * (size.y / 2);
      final bulletPosition = position + bulletOffset;
      parent?.add(Bullet(position: bulletPosition, direction: angle));
      return;
    }

    for (int i = 0; i < fireCount; i++) {
      final t = fireCount == 2 ? (i == 0 ? -0.5 : 0.5) : (i - 1);
      final bulletAngle = angle + spread * t;
      final bulletOffset =
          Vector2(sin(bulletAngle), -cos(bulletAngle)) * (size.y / 2);
      parent?.add(Bullet(position: position + bulletOffset, direction: bulletAngle));
    }
  }

  void _applyMovement(double dt) {
    if (_velocity.length2 > GameTuning.shipMaxSpeed * GameTuning.shipMaxSpeed) {
      _velocity = _velocity.normalized() * GameTuning.shipMaxSpeed;
    }

    position += _velocity * dt;

    final drag = pow(GameTuning.shipLinearDrag, dt * 60).toDouble();
    _velocity *= drag;
  }
}
