import 'package:asteroids/audio/sfx_player.dart';
import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/config/game_tuning.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Represents the different states of the game.
enum GameState { menu, playing, gameOver }

/// Manages the game state and handles transitions between states.
class GameStateManager {
  GameStateManager({required this.game, required this.sfx});

  final AsteroidsGame game;
  final SfxPlayer sfx;

  static const String _highScoreKey = 'high_score';

  GameState _currentState = GameState.menu;
  String? _lastGameOverReason;

  GameState get currentState => _currentState;

  bool get isPlaying => _currentState == GameState.playing;
  bool get isGameOver => _currentState == GameState.gameOver;
  bool get isInMenu => _currentState == GameState.menu;

  int _score = 0;
  int _highScore = 0;

  int get score => _score;
  int get highScore => _highScore;
  String? get lastGameOverReason => _lastGameOverReason;

  /// Whether current score is a new high score.
  bool get isNewHighScore => _score > 0 && _score >= _highScore;

  /// Loads the high score from persistent storage.
  Future<void> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt(_highScoreKey) ?? 0;
  }

  /// Saves the high score to persistent storage.
  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_highScoreKey, _highScore);
  }

  /// Adds points to the score.
  void addScore(int points) {
    _score += points;
  }

  /// Updates high score if current score is higher.
  Future<void> _updateHighScore() async {
    if (_score > _highScore) {
      _highScore = _score;
      await _saveHighScore();
    }
  }

  /// Triggers the game over state.
  Future<void> triggerGameOver({String reason = 'Game Over'}) async {
    if (_currentState == GameState.gameOver || _currentState == GameState.menu) {
      return;
    }

    _currentState = GameState.gameOver;
    _lastGameOverReason = reason;

    await _updateHighScore();
    await sfx.play(GameAudio.gameOver);
    game.overlays.add(AsteroidsGame.overlayGameOver);
    game.pauseEngine();
  }

  /// Restarts the game and resets to playing state.
  void restartGame() {
    _currentState = GameState.playing;
    _score = 0;
    _lastGameOverReason = null;
    game.overlays.remove(AsteroidsGame.overlayGameOver);
    game.resumeEngine();

    game.world.removeAll(game.world.children);
    game.resetWorld();
  }

  /// Scores a destroyed meteor based on its size.
  void scoreMeteor({required bool isLarge}) {
    addScore(
      isLarge ? GameTuning.largeMeteorPoints : GameTuning.smallMeteorPoints,
    );
  }

  /// Moves the game to the start menu state.
  void enterMenu() {
    _currentState = GameState.menu;
    _lastGameOverReason = null;
  }

  /// Starts a new game run.
  void startGame() {
    _currentState = GameState.playing;
    _score = 0;
    _lastGameOverReason = null;
  }
}
