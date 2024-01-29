import 'package:flame_study/player/model/player_resource_model.dart';

sealed class PlayerModel {
  PlayerResource get playerResource;

  PlayerAnimationState state;

  PlayerModel({this.state = PlayerAnimationState.idle});
}

class NinjaFrog extends PlayerModel {
  @override
  PlayerResource get playerResource => NinjaFrogRes();
}

class MaskDude extends PlayerModel {
  @override
  PlayerResource get playerResource => MaskDudeRes();
}
