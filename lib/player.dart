import 'dart:math';
import 'package:asteroids/bullet.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class Ship extends SpriteComponent with KeyboardHandler {
  Ship({super.position}) : super(size: Vector2.all(50), anchor: Anchor.center);

  // Movement and rotation speeds
  static const double moveSpeed = 200; // pixels per second
  static const double rotateSpeed = 3; // radians per second

  // Shooting
  static const double shootCooldown = 0.2; // seconds between shots
  double _timeSinceLastShot = 0;

  // Track pressed keys
  final Set<LogicalKeyboardKey> _keysPressed = {};

  // Thruster effect
  late SpriteComponent _thrusterEffect;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ship_G.png');

    // Create thruster effect as a child component
    _thrusterEffect = SpriteComponent(
      sprite: await Sprite.load('effect_purple.png'),
      size: Vector2(30, 30), // Adjust size as needed
      anchor: Anchor.topCenter,
      position: Vector2(
        size.x / 2,
        size.y - 10,
      ), // Position at the back of the ship
    );
    _thrusterEffect.opacity = 0; // Hidden by default
    add(_thrusterEffect);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update shooting cooldown
    _timeSinceLastShot += dt;

    // Check if moving forward
    final isThrusting = _keysPressed.contains(LogicalKeyboardKey.keyW);
    _thrusterEffect.opacity = isThrusting ? 1 : 0;

    // Apply movement based on pressed keys
    if (isThrusting) {
      // Move forward in the direction the ship is facing
      position.x += sin(angle) * moveSpeed * dt;
      position.y -= cos(angle) * moveSpeed * dt;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyS)) {
      // Move backward (opposite direction)
      position.x -= sin(angle) * moveSpeed * dt;
      position.y += cos(angle) * moveSpeed * dt;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyA)) {
      angle -= rotateSpeed * dt;
    }
    if (_keysPressed.contains(LogicalKeyboardKey.keyD)) {
      angle += rotateSpeed * dt;
    }

    // Shoot bullets
    if (_keysPressed.contains(LogicalKeyboardKey.space) &&
        _timeSinceLastShot >= shootCooldown) {
      _shoot();
      _timeSinceLastShot = 0;
    }
  }

  void _shoot() {
    // Calculate bullet spawn position (at the front of the ship)
    final bulletOffset = Vector2(sin(angle), -cos(angle)) * (size.y / 2);
    final bulletPosition = position + bulletOffset;

    // Create and add bullet to the parent (game world)
    final bullet = Bullet(position: bulletPosition, direction: angle);
    parent?.add(bullet);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    _keysPressed.clear();
    _keysPressed.addAll(keysPressed);
    return true;
  }
}
