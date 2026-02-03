import 'package:asteroids/audio/flame_sfx_player.dart';
import 'package:asteroids/audio/sfx_player.dart';
import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/game/game_state_manager.dart';
import 'package:asteroids/world/game_world.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

/// Root Flame game for the Asteroids experience.
class AsteroidsGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  AsteroidsGame({SfxPlayer? sfxPlayer}) : sfx = sfxPlayer ?? FlameSfxPlayer();

  static const String overlayStart = 'Start';
  static const String overlayGameOver = 'GameOver';

  /// Sound effects player used across the game.
  final SfxPlayer sfx;

  late final GameStateManager stateManager;
  late String selectedShipAsset;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await _preloadAssets();

    stateManager = GameStateManager(game: this, sfx: sfx);
    await stateManager.loadHighScore();
    selectedShipAsset = GameAssets.ship;
    world = GameWorld(shipAsset: selectedShipAsset);
    stateManager.enterMenu();
    overlays.add(overlayStart);
    pauseEngine();
  }

  /// Preload audio and image assets.
  Future<void> _preloadAssets() async {
    await sfx.preload();
    await images.loadAll(GameAssets.preloadImages);
  }

  /// Resets the world to a fresh state.
  void resetWorld() {
    world = GameWorld(shipAsset: selectedShipAsset);
  }

  /// Restarts the game (delegates to state manager).
  void restart() {
    stateManager.restartGame();
  }

  /// Starts a new run using the selected ship.
  Future<void> startGame({required String shipAsset}) async {
    selectedShipAsset = shipAsset;
    world = GameWorld(shipAsset: selectedShipAsset);
    stateManager.startGame();
    overlays.remove(overlayStart);
    await sfx.play(GameAudio.gameStart);
    resumeEngine();
  }
}
