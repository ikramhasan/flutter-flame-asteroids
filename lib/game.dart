import 'package:asteroids/game_state.dart';
import 'package:asteroids/world.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';

class AsteroidsGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final GameStateManager stateManager;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Preload assets to prevent frame drops
    await _preloadAssets();
    
    stateManager = GameStateManager(this);
    world = GameWorld();
  }

  /// Preload audio and image assets
  Future<void> _preloadAssets() async {
    // Preload audio files
    await FlameAudio.audioCache.loadAll([
      'TECH WEAPON Gun Shot Phaser Down 02.wav',
      'EXPLOSION Bang 04.wav',
      'NEGATIVE Failure Descending Chime 05.wav',
      'TECH INTERFACE Computer Terminal Beeps Negative 03.wav',
    ]);

    // Preload bullet sprite
    await images.load('star_tiny.png');
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
