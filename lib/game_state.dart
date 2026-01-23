import 'package:asteroids/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum representing the different states of the game
enum GameState { playing, gameOver }

/// Manages the game state and handles transitions between states
class GameStateManager {
  GameStateManager(this.game);

  final AsteroidsGame game;

  static const String _highScoreKey = 'high_score';

  GameState _currentState = GameState.playing;

  GameState get currentState => _currentState;

  bool get isPlaying => _currentState == GameState.playing;
  bool get isGameOver => _currentState == GameState.gameOver;

  // Scoring system
  static const int largeMeteorPoints = 50;
  static const int smallMeteorPoints = 100;

  int _score = 0;
  int _highScore = 0;

  int get score => _score;
  int get highScore => _highScore;

  /// Whether current score is a new high score
  bool get isNewHighScore => _score > 0 && _score >= _highScore;

  /// Loads the high score from persistent storage
  Future<void> loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    _highScore = prefs.getInt(_highScoreKey) ?? 0;
  }

  /// Saves the high score to persistent storage
  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_highScoreKey, _highScore);
  }

  /// Adds points to the score
  void addScore(int points) {
    _score += points;
  }

  /// Updates high score if current score is higher
  Future<void> _updateHighScore() async {
    if (_score > _highScore) {
      _highScore = _score;
      await _saveHighScore();
    }
  }

  /// Triggers the game over state
  Future<void> triggerGameOver({String reason = 'Game Over'}) async {
    if (_currentState == GameState.gameOver) {
      return; // Prevent multiple triggers
    }

    _currentState = GameState.gameOver;
    
    // Update high score before showing game over screen
    await _updateHighScore();
    
    FlameAudio.play('NEGATIVE Failure Descending Chime 05.wav');
    game.overlays.add('GameOver');
    game.pauseEngine();
  }

  /// Restarts the game and resets to playing state
  void restartGame() {
    _currentState = GameState.playing;
    _score = 0; // Reset score
    game.overlays.remove('GameOver');
    game.resumeEngine();

    // Remove all children from the current world and recreate
    game.world.removeAll(game.world.children);
    game.resetWorld();
  }
}
