import 'package:asteroids/game.dart';
import 'package:flame_audio/flame_audio.dart';

/// Enum representing the different states of the game
enum GameState { playing, gameOver }

/// Manages the game state and handles transitions between states
class GameStateManager {
  GameStateManager(this.game);

  final AsteroidsGame game;

  GameState _currentState = GameState.playing;

  GameState get currentState => _currentState;

  bool get isPlaying => _currentState == GameState.playing;
  bool get isGameOver => _currentState == GameState.gameOver;

  // Scoring system
  static const int largeMeteorPoints = 50;
  static const int smallMeteorPoints = 100;

  int _score = 0;

  int get score => _score;

  /// Adds points to the score
  void addScore(int points) {
    _score += points;
  }

  /// Triggers the game over state
  void triggerGameOver({String reason = 'Game Over'}) {
    if (_currentState == GameState.gameOver) {
      return; // Prevent multiple triggers
    }

    _currentState = GameState.gameOver;
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

