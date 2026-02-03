import 'package:asteroids/config/game_assets.dart';
import 'package:flame_audio/flame_audio.dart';

import 'sfx_player.dart';

/// Flame-backed implementation of [SfxPlayer].
class FlameSfxPlayer implements SfxPlayer {
  @override
  Future<void> preload() async {
    await FlameAudio.audioCache.loadAll([
      GameAudio.shoot,
      GameAudio.explosion,
      GameAudio.gameOver,
      GameAudio.gameStart,
    ]);
  }

  @override
  Future<void> play(String asset, {double volume = 1}) async {
    await FlameAudio.play(asset, volume: volume);
  }
}
