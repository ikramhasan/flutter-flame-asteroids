import 'package:asteroids/game.dart';
import 'package:flutter/material.dart';

class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({super.key, required this.game});

  final AsteroidsGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GAME OVER',
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
                fontFamily: 'Kenney',
                letterSpacing: 4,
                shadows: [Shadow(color: Colors.red, blurRadius: 20)],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'SCORE: ${game.stateManager.score}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Kenney',
                letterSpacing: 2,
                shadows: [Shadow(color: Colors.blueAccent, blurRadius: 10)],
              ),
            ),
            const SizedBox(height: 16),
            if (game.stateManager.isNewHighScore)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.amber, Colors.orange],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withValues(alpha: 0.5),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Text(
                  '🏆 NEW HIGH SCORE! 🏆',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Kenney',
                    letterSpacing: 1,
                  ),
                ),
              ),
            if (!game.stateManager.isNewHighScore)
              Text(
                'HIGH SCORE: ${game.stateManager.highScore}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade300,
                  fontFamily: 'Kenney',
                  letterSpacing: 2,
                  shadows: const [Shadow(color: Colors.amber, blurRadius: 10)],
                ),
              ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                game.restart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 8,
              ),
              child: const Text(
                'PLAY AGAIN',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kenney',
                  letterSpacing: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
