import 'dart:math';
import 'package:asteroids/meteor.dart';
import 'package:asteroids/player.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class GameWorld extends World with HasGameReference {
  @override
  Future<void> onLoad() async {
    add(Ship(position: Vector2(0, 0)));
    await FlameAudio.play(
      'TECH INTERFACE Computer Terminal Beeps Negative 03.wav',
    );
    
    // Add the meteor spawner
    add(MeteorSpawner());
  }
}

/// Spawner component that periodically creates meteors from off-screen
class MeteorSpawner extends Component with HasGameReference {
  static final _random = Random();

  /// Time between meteor spawns in seconds
  static const double spawnInterval = 1.5;

  /// Speed range for meteors
  static const double minSpeed = 50;
  static const double maxSpeed = 150;

  double _timeSinceLastSpawn = 0;

  @override
  void update(double dt) {
    super.update(dt);

    _timeSinceLastSpawn += dt;

    if (_timeSinceLastSpawn >= spawnInterval) {
      _spawnMeteor();
      _timeSinceLastSpawn = 0;
    }
  }

  void _spawnMeteor() {
    final visibleRect = game.camera.visibleWorldRect;

    // Random size between 50 and 100
    final meteorSize = 50 + _random.nextDouble() * 40;

    // Determine spawn position from one of the four edges
    final edge = _random.nextInt(4);
    Vector2 spawnPosition;
    Vector2 velocity;

    // Margin to spawn outside the visible area
    const spawnMargin = 100.0;

    switch (edge) {
      case 0: // Top edge - spawn above screen, move downward
        spawnPosition = Vector2(
          visibleRect.left + _random.nextDouble() * visibleRect.width,
          visibleRect.top - spawnMargin,
        );
        velocity = Vector2(
          (_random.nextDouble() - 0.5) * 100, // Slight horizontal variation
          minSpeed + _random.nextDouble() * (maxSpeed - minSpeed), // Move down
        );
        break;
      case 1: // Bottom edge - spawn below screen, move upward
        spawnPosition = Vector2(
          visibleRect.left + _random.nextDouble() * visibleRect.width,
          visibleRect.bottom + spawnMargin,
        );
        velocity = Vector2(
          (_random.nextDouble() - 0.5) * 100,
          -(minSpeed + _random.nextDouble() * (maxSpeed - minSpeed)), // Move up
        );
        break;
      case 2: // Left edge - spawn left of screen, move right
        spawnPosition = Vector2(
          visibleRect.left - spawnMargin,
          visibleRect.top + _random.nextDouble() * visibleRect.height,
        );
        velocity = Vector2(
          minSpeed + _random.nextDouble() * (maxSpeed - minSpeed), // Move right
          (_random.nextDouble() - 0.5) * 100, // Slight vertical variation
        );
        break;
      default: // Right edge - spawn right of screen, move left
        spawnPosition = Vector2(
          visibleRect.right + spawnMargin,
          visibleRect.top + _random.nextDouble() * visibleRect.height,
        );
        velocity = Vector2(
          -(minSpeed +
              _random.nextDouble() * (maxSpeed - minSpeed)), // Move left
          (_random.nextDouble() - 0.5) * 100,
        );
        break;
    }

    // Create and add the meteor (always spawn large meteors)
    final meteor = Meteor(
      position: spawnPosition,
      velocity: velocity,
      meteorSize: MeteorSize.large,
      size: meteorSize,
    );

    parent?.add(meteor);
  }
}
