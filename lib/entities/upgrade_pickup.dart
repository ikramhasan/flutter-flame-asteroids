import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:asteroids/entities/ship.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Collectible that upgrades the ship's weapons.
class UpgradePickup extends SpriteComponent
    with CollisionCallbacks, HasGameReference<AsteroidsGame> {
  UpgradePickup({required super.position})
      : super(
          size: Vector2.all(28),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(GameAssets.upgradeIcon);
    add(CircleHitbox());
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
