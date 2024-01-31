import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flame/components.dart';
import 'package:flame_study/collisions/collision_block.dart';
import 'package:flame_study/pixel_adventure.dart';
import 'package:flame_study/player/model/player_model.dart';
import 'package:flame_study/player/model/player_resource_model.dart';
import 'package:flame_study/util/position_util.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class PlayerComponent
    extends SpriteAnimationGroupComponent<PlayerAnimationState>
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  PlayerComponent({
    Vector2? position,
    required this.player,
    required this.collisionBlocks,
  }) : super(position: position) {
    debugMode = kDebugMode;
  }

  final PlayerModel player;
  final List<CollisionBlock> collisionBlocks;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;

  Vector2 velocity = Vector2.zero();

  @override
  FutureOr<void> onLoad() async {
    _loadAllAnimations();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // apply gravity every dt.
    player.onEvent(ApplyGravity());

    // Update x.
    position.x += player.horizonVelocity * dt;

    // resolve x position by checking collisions.
    _resolveHorizontalPosition();

    // Update y.
    position.y += player.verticalVelocity * dt;

    // resolve y position by checking collisions.
    _resolveVerticalPosition();

    _updatePlayeAnimationState(dt);
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

  void _updatePlayeAnimationState(double dt) {
    final animation = player.currentAnimationState;
    current = animation;

    if (player.isFacingRight != _isCurrentFacingRight()) {
      flipHorizontallyAroundCenter();
    }
  }

  void _resolveHorizontalPosition() {
    final block = _detectOverlappedSolidCollision();

    if (block == null) return;

    if (player.playerDirection == PlayerDirection.right) {
      position.x = block.left - width;
    }

    if (player.playerDirection == PlayerDirection.left) {
      position.x = block.right + width ;
    }
  }

  void _resolveVerticalPosition() {
    final block = _detectOverlappedSolidCollision();

    if (block == null) return;

    if (player.isFalling) {
      player.onEvent(LandGround());

      position.y = block.y - height;
    }
  }

  bool _isCurrentFacingRight() => scale.x > 0;

  CollisionBlock? _detectOverlappedSolidCollision() {
    return collisionBlocks
            .where((element) => !element.isPlatform)
            .firstWhereOrNull((block) => rect.overlaps(block.rect));
  }

}
