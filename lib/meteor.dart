import 'dart:math';
import 'package:asteroids/bullet.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class MeteorSprite {
  final String large;
  final String small;

  MeteorSprite({required this.large, required this.small});
}

/// Enum to track meteor size
enum MeteorSize { large, small }

class Meteor extends SpriteComponent with HasGameReference, CollisionCallbacks {
  Meteor({
    required super.position,
    required this.velocity,
    this.meteorSize = MeteorSize.large,
    this.spriteIndex,
    double? size,
  }) : super(
         size: Vector2.all(size ?? (meteorSize == MeteorSize.large ? 70 : 35)),
         anchor: Anchor.center,
       );

  /// Velocity in pixels per second
  final Vector2 velocity;

  /// Size category of the meteor
  final MeteorSize meteorSize;

  /// Index of the sprite in the list (used to keep same sprite type when splitting)
  final int? spriteIndex;

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
      large: 'meteor_squareLarge.png',
      small: 'meteor_squareSmall.png',
    ),
  ];

  static final _random = Random();

  late final int _selectedSpriteIndex;

  @override
  Future<void> onLoad() async {
    // Use provided sprite index or randomly select one
    _selectedSpriteIndex =
        spriteIndex ?? _random.nextInt(_meteorSprites.length);
    final selectedSprite = _meteorSprites[_selectedSpriteIndex];

    // Load the appropriate sprite based on size
    if (meteorSize == MeteorSize.large) {
      sprite = await Sprite.load(selectedSprite.large);
    } else {
      sprite = await Sprite.load(selectedSprite.small);
    }

    // Add some random rotation for visual variety
    angle = _random.nextDouble() * 2 * pi;

    // Add hitbox for collision detection
    add(CircleHitbox());
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

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Bullet) {
      // Play explosion sound
      FlameAudio.play('EXPLOSION Bang 04.wav');

      // Remove the bullet
      other.removeFromParent();

      if (meteorSize == MeteorSize.large) {
        // Large meteor: spawn 2-3 small meteors
        _spawnSmallMeteors();
      }

      // Remove this meteor
      removeFromParent();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _spawnSmallMeteors() {
    // Spawn 2-3 small meteors
    final count = 2 + _random.nextInt(2); // 2 or 3

    for (int i = 0; i < count; i++) {
      // Create random velocity in different directions
      final angle = _random.nextDouble() * 2 * pi;
      final speed = 80 + _random.nextDouble() * 80; // 80-160 speed
      final newVelocity = Vector2(cos(angle) * speed, sin(angle) * speed);

      // Small meteor size between 25-40
      final smallSize = 25 + _random.nextDouble() * 15;

      final smallMeteor = Meteor(
        position: position.clone(),
        velocity: newVelocity,
        meteorSize: MeteorSize.small,
        spriteIndex: _selectedSpriteIndex, // Keep same sprite type
        size: smallSize,
      );

      parent?.add(smallMeteor);
    }
  }
}
