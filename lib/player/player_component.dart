import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_study/pixel_adventure.dart';
import 'package:flame_study/player/model/player_model.dart';
import 'package:flame_study/player/model/player_resource_model.dart';

class PlayerComponent
    extends SpriteAnimationGroupComponent<PlayerAnimationState>
    with HasGameRef<PixelAdventure> {
  final PlayerModel player;

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;

  PlayerComponent({required this.player});

  @override
  FutureOr<void> onLoad() async {
    _loadAllAnimations();
  }

  void _loadAllAnimations() {
    animations = player.playerResource.getAnimationMap(game.images);

    current = player.state;
  }
}
