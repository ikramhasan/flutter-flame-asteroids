/// Tunable gameplay values.
class GameTuning {
  GameTuning._();

  // Ship
  static const double shipSize = 50;
  static const double shipMoveSpeed = 200;
  static const double shipRotateSpeed = 3;
  static const double shipShootCooldown = 0.2;
  static const double thrusterWidth = 30;
  static const double thrusterHeight = 20;
  static const double thrusterOffset = 10;
  static const double shipThrustAcceleration = 420;
  static const double shipMaxSpeed = 320;
  static const double shipLinearDrag = 0.95;

  // Upgrades
  static const double upgradeSpawnInterval = 12;
  static const double upgradeSpawnPadding = 60;

  // Bullet
  static const double bulletSize = 8;
  static const double bulletSpeed = 500;
  static const double bulletOffscreenMargin = 50;

  // Meteor spawner
  static const double meteorSpawnInterval = 1.5;
  static const double meteorMinSpeed = 50;
  static const double meteorMaxSpeed = 150;
  static const double meteorSpawnMargin = 100;
  static const double meteorLargeSpawnMinSize = 50;
  static const double meteorLargeSpawnSizeRange = 40;

  // Meteors
  static const double meteorLargeBaseSize = 70;
  static const double meteorSmallBaseSize = 35;
  static const double meteorOffscreenMargin = 150;
  static const double meteorRotationSpeed = 0.5;
  static const int meteorSplitMin = 2;
  static const int meteorSplitRange = 2;
  static const double meteorSplitMinSpeed = 80;
  static const double meteorSplitSpeedRange = 80;
  static const double meteorSplitMinSize = 25;
  static const double meteorSplitSizeRange = 15;

  // Enemies
  static const double enemySpawnInterval = 8;
  static const double enemySpawnMargin = 120;
  static const double enemyOffscreenMargin = 220;
  static const double enemySpeed = 90;
  static const double enemyShootCooldown = 1.6;
  static const double enemySize = 42;
  static const double enemyBulletSpeed = 360;
  static const int enemyLevelScoreStep = 250;

  // Scoring
  static const int largeMeteorPoints = 50;
  static const int smallMeteorPoints = 100;
}
