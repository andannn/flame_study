import 'package:flame_study/player/model/player_resource_model.dart';

sealed class PlayerEvent {}

class MoveLeft extends PlayerEvent {}

class MoveRight extends PlayerEvent {}

class MoveStop extends PlayerEvent {}

class Jump extends PlayerEvent {}

class ApplyGravity extends PlayerEvent {}

class LandGround extends PlayerEvent {}

class ReachCeiling extends PlayerEvent {}

enum PlayerDirection {
  left,
  right,
  none;
}

sealed class PlayerModel {
  PlayerModel();

  PlayerResource get playerResource;

  final double moveSpeed = 180;
  final double gravity = 15.8;
  final double jumpForceVelocity = 360;
  final double terminalVelocity = 300;

  PlayerDirection playerDirection = PlayerDirection.none;
  bool isFacingRight = true;
  double verticalVelocity = 0;
  bool isJumping = false;

  void onEvent(PlayerEvent event) {
    switch (event) {
      case ApplyGravity():
        verticalVelocity = (verticalVelocity + gravity)
            .clamp(-jumpForceVelocity, terminalVelocity);
      case LandGround():
        verticalVelocity = 0;
        isJumping = false;
      case ReachCeiling():
        verticalVelocity = 0;
      case Jump():
        if (!isJumping) {
          verticalVelocity += -jumpForceVelocity;
          isJumping = true;
        }
      case MoveLeft():
        playerDirection = PlayerDirection.left;
        isFacingRight = false;
      case MoveRight():
        playerDirection = PlayerDirection.right;
        isFacingRight = true;
      case MoveStop():
        playerDirection = PlayerDirection.none;
    }
  }
}

class NinjaFrog extends PlayerModel {
  @override
  PlayerResource get playerResource => NinjaFrogRes();
}

class MaskDude extends PlayerModel {
  @override
  PlayerResource get playerResource => MaskDudeRes();

  @override
  double get moveSpeed => 120;
}

extension PlayerModelEx on PlayerModel {
  bool get isFalling => verticalVelocity > 0;
  bool get isRising => verticalVelocity < 0;

  double get horizonVelocity {
    switch (playerDirection) {
      case PlayerDirection.left:
        return -1 * moveSpeed;
      case PlayerDirection.right:
        return 1 * moveSpeed;
      case PlayerDirection.none:
        return 0;
    }
  }

  PlayerAnimationState get currentAnimationState {
    if (isJumping && isRising) {
      return PlayerAnimationState.jump;
    } else if (isJumping && isFalling) {
      return PlayerAnimationState.fail;
    }

    if (playerDirection == PlayerDirection.none) {
      return PlayerAnimationState.idle;
    } else {
      return PlayerAnimationState.running;
    }
  }
}
