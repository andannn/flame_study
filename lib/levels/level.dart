import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_study/player/model/player_model.dart';
import 'package:flame_study/player/player_component.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  Level({required this.playerModel});

  late TiledComponent level;
  final PlayerModel playerModel;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('Level-01.tmx', Vector2.all(16));

    add(level);

    final spawnPointsLayerObjects =
        level.tileMap.getLayer<ObjectGroup>("Spawnpoints")?.objects ?? [];

    final playerSpawnPoint = spawnPointsLayerObjects.firstWhere(
      (e) => e.class_ == 'Player',
    );
    add(
      PlayerComponent(
        player: playerModel,
        position: Vector2(playerSpawnPoint.x, playerSpawnPoint.y),
      ),
    );
    return super.onLoad();
  }
}
