import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_study/pixel_adventure.dart';
import 'package:flame_study/player/model/player_model.dart';
import 'package:flame_study/player/model/player_resource_model.dart';
import 'package:flutter/services.dart';


class PlayerComponent
    extends SpriteAnimationGroupComponent<PlayerAnimationState>
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  PlayerComponent({Vector2? position, required this.player})
      : super(position: position);

  final PlayerModel player;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;

  double moveSpeed = 180;
  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    _loadAllAnimations();
  }

  @override
  void update(double dt) {
    super.update(dt);
    _updatePlayerByModel(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    if (isLeftKeyPressed) {
      player.onEvent(MoveLeft());
    } else if (isRightKeyPressed) {
      player.onEvent(MoveRight());
    } else {
      player.onEvent(MoveStop());
    }

    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    animations = player.playerResource.getAnimationMap(game.images);

    current = player.currentAnimationState;
  }

  var isFacingRight = true;

  void _updatePlayerByModel(double dt) {
    final horizontalSpeed = player.currentHorizonSpeed;
    position.x += horizontalSpeed * dt;

    final animation = player.currentAnimationState;
    current = animation;

    if (player.isFacingRight != _isCurrentFacingRight()) {
      flipHorizontallyAroundCenter();
    }
  }

  bool _isCurrentFacingRight() => scale.x > 0;
}
