import 'dart:math';
import 'package:flame/components.dart';

class MeteorSprite {
  final String large;
  final String small;

  MeteorSprite({required this.large, required this.small});
}

class Meteor extends SpriteComponent with HasGameReference {
  Meteor({
    required super.position,
    required this.velocity,
    double meteorSize = 70,
  }) : super(size: Vector2.all(meteorSize), anchor: Anchor.center);

  /// Velocity in pixels per second
  final Vector2 velocity;

  /// List of available meteor sprites
  static final _meteorSprites = [
    MeteorSprite(large: 'meteor_large.png', small: 'meteor_small.png'),
    MeteorSprite(
      large: 'meteor_detailedLarge.png',
      small: 'meteor_detailedSmall.png',
    ),
    MeteorSprite(
      large: 'meteor_squareDetailedLarge.png',
      small: 'meteor_squareDetailedSmall.png',
    ),
    MeteorSprite(
      large: 'meteor_squareDetailedLarge.png',
      small: 'meteor_squareDetailedSmall.png',
    ),
  ];

  static final _random = Random();

  @override
  Future<void> onLoad() async {
    // Randomly select a large sprite from the list
    final selectedSprite =
        _meteorSprites[_random.nextInt(_meteorSprites.length)];
    sprite = await Sprite.load(selectedSprite.large);

    // Add some random rotation for visual variety
    angle = _random.nextDouble() * 2 * pi;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Move the meteor based on velocity
    position += velocity * dt;

    // Slowly rotate the meteor for visual effect
    angle += 0.5 * dt;

    // Remove meteor if it goes off screen
    final visibleRect = game.camera.visibleWorldRect;
    const margin = 150.0; // Extra margin to ensure meteor is fully off screen
    if (position.x < visibleRect.left - margin ||
        position.x > visibleRect.right + margin ||
        position.y < visibleRect.top - margin ||
        position.y > visibleRect.bottom + margin) {
      removeFromParent();
    }
  }
}
