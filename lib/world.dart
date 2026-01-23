import 'package:asteroids/player.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';

class GameWorld extends World {
  @override
  Future<void> onLoad() async {
    add(Ship(position: Vector2(0, 0)));
    await FlameAudio.play(
      'TECH INTERFACE Computer Terminal Beeps Negative 03.wav',
    );
  }
}
