import 'package:asteroids/world.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class AsteroidsGame extends FlameGame with HasKeyboardHandlerComponents {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    world = GameWorld();
  }
}
