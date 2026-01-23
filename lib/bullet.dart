import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class Bullet extends SpriteComponent with HasGameReference {
  Bullet({required super.position, required this.direction, this.speed = 500})
    : super(size: Vector2.all(8), anchor: Anchor.center);

  final double direction; // angle in radians
  final double speed; // pixels per second

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('star_tiny.png');
    await FlameAudio.play(
      'TECH WEAPON Gun Shot Phaser Down 02.wav',
      volume: 0.5,
    );

    // Add hitbox for collision detection with meteors
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move bullet in its direction
    position.x += sin(direction) * speed * dt;
    position.y -= cos(direction) * speed * dt;

    // Remove bullet if it goes off screen (using camera's visible area)
    final visibleRect = game.camera.visibleWorldRect;
    const margin = 50.0;
    if (position.x < visibleRect.left - margin ||
        position.x > visibleRect.right + margin ||
        position.y < visibleRect.top - margin ||
        position.y > visibleRect.bottom + margin) {
      removeFromParent();
    }
  }
}
