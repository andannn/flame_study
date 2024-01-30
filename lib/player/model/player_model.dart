import 'package:flame_study/player/model/player_resource_model.dart';

sealed class PlayerEvent {}

class MoveLeft extends PlayerEvent {}

class MoveRight extends PlayerEvent {}

class MoveStop extends PlayerEvent {}

class Jump extends PlayerEvent {}

enum PlayerDirection {
  left,
  right,
  none;
}

sealed class PlayerModel {
  PlayerModel();

  PlayerResource get playerResource;

  double moveSpeed = 180;

  PlayerDirection playerDirection = PlayerDirection.none;

  bool isFacingRight = true;

  void onEvent(PlayerEvent event) {
    switch (event) {
      case MoveLeft():
        playerDirection = PlayerDirection.left;
        isFacingRight = false;
      case MoveRight():
        playerDirection = PlayerDirection.right;
        isFacingRight = true;
      case MoveStop():
        playerDirection = PlayerDirection.none;
      case Jump():
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

  double get currentHorizonSpeed {
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
    if (playerDirection == PlayerDirection.none) {
      return PlayerAnimationState.idle;
    } else {
      return PlayerAnimationState.running;
    }
  }
}