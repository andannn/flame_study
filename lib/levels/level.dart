import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_study/player/model/player_model.dart';
import 'package:flame_study/player/player_component.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));

    add(level);
    add(PlayerComponent(player: MaskDude()));

    return super.onLoad();
  }
}
