/// Asset paths used by the game.
class GameAssets {
  GameAssets._();

  static const String imagesPath = 'assets/images/';

  static const ship = 'ship_G.png';
  static const thruster = 'effect_purple.png';
  static const bullet = 'star_tiny.png';
  static const upgradeIcon = 'icon_plusSmall.png';

  static const meteorLarge = 'meteor_large.png';
  static const meteorSmall = 'meteor_small.png';
  static const meteorDetailedLarge = 'meteor_detailedLarge.png';
  static const meteorDetailedSmall = 'meteor_detailedSmall.png';
  static const meteorSquareDetailedLarge = 'meteor_squareDetailedLarge.png';
  static const meteorSquareDetailedSmall = 'meteor_squareDetailedSmall.png';
  static const meteorSquareLarge = 'meteor_squareLarge.png';
  static const meteorSquareSmall = 'meteor_squareSmall.png';

  /// Selectable ship sprites.
  static const List<String> shipVariants = [
    'ship_E.png',
    'ship_G.png',
    'ship_H.png',
    'ship_I.png',
    'ship_J.png',
    'ship_K.png',
    'ship_L.png',
  ];

  /// Images to preload at startup.
  static const List<String> preloadImages = [
    ...shipVariants,
    thruster,
    bullet,
    upgradeIcon,
    meteorLarge,
    meteorSmall,
    meteorDetailedLarge,
    meteorDetailedSmall,
    meteorSquareDetailedLarge,
    meteorSquareDetailedSmall,
    meteorSquareLarge,
    meteorSquareSmall,
  ];

  /// Returns the full asset path for a sprite in `assets/images/`.
  static String imagePath(String fileName) => '$imagesPath$fileName';
}

/// Audio asset names used by the game.
class GameAudio {
  GameAudio._();

  static const shoot = 'TECH WEAPON Gun Shot Phaser Down 02.wav';
  static const explosion = 'EXPLOSION Bang 04.wav';
  static const gameOver = 'NEGATIVE Failure Descending Chime 05.wav';
  static const gameStart =
      'TECH INTERFACE Computer Terminal Beeps Negative 03.wav';
}
