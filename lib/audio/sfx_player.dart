/// Plays short sound effects.
abstract class SfxPlayer {
  /// Preloads all audio assets needed for the game.
  Future<void> preload();

  /// Plays a one-shot sound effect.
  Future<void> play(String asset, {double volume = 1});
}
