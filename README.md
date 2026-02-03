# Asteroids (Flutter + Flame)

A modern take on the classic Asteroids experience built with Flutter and Flame. It features ship selection, progressive difficulty, weapon upgrades, and arcade controls.

## Features
- Ship selection screen with 7 ship variants
- Classic inertial movement (glide) with rotation controls
- Meteors that split and score system with high score persistence
- Weapon upgrades (two levels) with a collectible pickup
- Enemy ships that spawn progressively and engage the player
- UI overlays (start screen + game over)

## Controls
- Thrust: `W` or `Arrow Up`
- Rotate Left: `A` or `Arrow Left`
- Rotate Right: `D` or `Arrow Right`
- Fire: `Space`

## Gameplay Notes
- Enemies begin spawning after the first weapon upgrade is collected.
- Enemy tiers unlock progressively as your score increases.
- Weapon upgrades appear twice; after the second, no more upgrades spawn.

## Project Structure
- `lib/audio/` Sound effect abstraction
- `lib/config/` Assets and tuning constants
- `lib/entities/` Player, meteors, bullets, enemies, upgrades
- `lib/game/` Game root and state manager
- `lib/ui/` Flutter overlays
- `lib/utils/` Shared helpers
- `lib/world/` World and spawners

## Run Locally
1. Install Flutter (stable channel)
2. Fetch packages: `flutter pub get`
3. Run: `flutter run`

## Tuning
Most gameplay values are centralized in `lib/config/game_tuning.dart`, including:
- Ship acceleration, drag, and max speed
- Meteor and enemy spawn rates
- Enemy movement and bullet speed

## Assets
All game sprites and audio are loaded from `assets/` and configured in `pubspec.yaml`.

## Credits
- [Flame](https://github.com/flame-engine/flame)
- [Flutter](https://github.com/flutter/flutter)
- [Sound effects](https://freesound.org/)
- [Assets](https://kenney.nl/assets/simple-space)