import 'package:asteroids/config/game_assets.dart';
import 'package:asteroids/game/asteroids_game.dart';
import 'package:flutter/material.dart';

/// Overlay shown before gameplay to select a ship and start.
class StartOverlay extends StatefulWidget {
  const StartOverlay({super.key, required this.game});

  final AsteroidsGame game;

  @override
  State<StartOverlay> createState() => _StartOverlayState();
}

class _StartOverlayState extends State<StartOverlay> {
  late String _selectedShip;

  @override
  void initState() {
    super.initState();
    _selectedShip = widget.game.selectedShipAsset;
  }

  @override
  Widget build(BuildContext context) {
    final shipOptions = GameAssets.shipVariants;

    return Container(
      color: Colors.black87,
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final crossAxisCount = width >= 700
                    ? 4
                    : width >= 520
                        ? 3
                        : 2;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'SELECT YOUR SHIP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Kenney',
                          letterSpacing: 3,
                        ),
                      ),
                      const SizedBox(height: 24),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: shipOptions.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final ship = shipOptions[index];
                          final isSelected = ship == _selectedShip;

                          return GestureDetector(
                            onTap: () => setState(() => _selectedShip = ship),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blueAccent.withValues(alpha: 0.3)
                                    : Colors.white10,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blueAccent
                                      : Colors.white24,
                                  width: 2,
                                ),
                              ),
                              child: Image.asset(
                                GameAssets.imagePath(ship),
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      const Text.rich(
                        TextSpan(
                          text: 'Controls: ',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white70,
                            fontFamily: 'Kenney',
                            letterSpacing: 1,
                          ),
                          children: [
                            TextSpan(
                              text: 'W/↑',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            TextSpan(text: ' thrust, '),
                            TextSpan(
                              text: 'A/←',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            TextSpan(text: ' rotate left, '),
                            TextSpan(
                              text: 'D/→',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            TextSpan(text: ' rotate right, '),
                            TextSpan(
                              text: 'Space',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            TextSpan(text: ' fire'),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          widget.game.startGame(shipAsset: _selectedShip);
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
                          'START',
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
