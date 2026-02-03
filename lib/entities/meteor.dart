import 'dart:math';

import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/entities/bullet.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/utils/viewport_bounds.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Enum to track meteor size.
enum MeteorSize { large, small }

class _MeteorSprite {
  const _MeteorSprite({required this.large, required this.small});

  final String large;
  final String small;
}

/// Flying obstacle that can split into smaller meteors.
class Meteor extends SpriteComponent
    with HasGameReference<AsteroidsGame>, CollisionCallbacks {
  Meteor({
    required super.position,
    required this.velocity,
    this.meteorSize = MeteorSize.large,
    this.spriteIndex,
    double? size,
  }) : super(
          size: Vector2.all(
            size ??
                (meteorSize == MeteorSize.large
                    ? GameTuning.meteorLargeBaseSize
                    : GameTuning.meteorSmallBaseSize),
          ),
          anchor: Anchor.center,
        );

  /// Velocity in pixels per second.
  final Vector2 velocity;

  /// Size category of the meteor.
  final MeteorSize meteorSize;

  /// Index of the sprite in the list (kept when splitting).
  final int? spriteIndex;

  static final _meteorSprites = [
    _MeteorSprite(large: GameAssets.meteorLarge, small: GameAssets.meteorSmall),
    _MeteorSprite(
      large: GameAssets.meteorDetailedLarge,
      small: GameAssets.meteorDetailedSmall,
    ),
    _MeteorSprite(
      large: GameAssets.meteorSquareDetailedLarge,
      small: GameAssets.meteorSquareDetailedSmall,
    ),
    _MeteorSprite(
      large: GameAssets.meteorSquareLarge,
      small: GameAssets.meteorSquareSmall,
    ),
  ];

  static final _random = Random();

  late final int _selectedSpriteIndex;

  @override
  Future<void> onLoad() async {
    _selectedSpriteIndex = spriteIndex ?? _random.nextInt(_meteorSprites.length);
    final selectedSprite = _meteorSprites[_selectedSpriteIndex];

    sprite = await Sprite.load(
      meteorSize == MeteorSize.large ? selectedSprite.large : selectedSprite.small,
    );

    angle = _random.nextDouble() * 2 * pi;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;
    angle += GameTuning.meteorRotationSpeed * dt;

    final bounds = ViewportBounds(game.camera.visibleWorldRect);
    if (bounds.isOutsidePosition(
      position,
      margin: GameTuning.meteorOffscreenMargin,
    )) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    if (other is Bullet) {
      _handleBulletHit(other);
    }
    super.onCollisionStart(intersectionPoints, other);
  }

  void _handleBulletHit(Bullet bullet) {
    game.sfx.play(GameAudio.explosion);
    bullet.removeFromParent();

    if (meteorSize == MeteorSize.large) {
      game.stateManager.scoreMeteor(isLarge: true);
      _spawnSmallMeteors();
    } else {
      game.stateManager.scoreMeteor(isLarge: false);
    }

    removeFromParent();
  }

  void _spawnSmallMeteors() {
    final count = GameTuning.meteorSplitMin +
        _random.nextInt(GameTuning.meteorSplitRange);

    for (int i = 0; i < count; i++) {
      final angle = _random.nextDouble() * 2 * pi;
      final speed = GameTuning.meteorSplitMinSpeed +
          _random.nextDouble() * GameTuning.meteorSplitSpeedRange;
      final newVelocity = Vector2(cos(angle) * speed, sin(angle) * speed);

      final smallSize = GameTuning.meteorSplitMinSize +
          _random.nextDouble() * GameTuning.meteorSplitSizeRange;

      parent?.add(
        Meteor(
          position: position.clone(),
          velocity: newVelocity,
          meteorSize: MeteorSize.small,
          spriteIndex: _selectedSpriteIndex,
          size: smallSize,
        ),
      );
    }
  }
}
