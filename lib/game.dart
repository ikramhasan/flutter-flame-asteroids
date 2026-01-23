import 'package:asteroids/game_state.dart';
import 'package:asteroids/world.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class AsteroidsGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final GameStateManager stateManager;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    stateManager = GameStateManager(this);
    world = GameWorld();
  }

  /// Resets the world to a fresh state
  void resetWorld() {
    world = GameWorld();
  }

  /// Restarts the game (delegates to state manager)
  void restart() {
    stateManager.restartGame();
  }
}
