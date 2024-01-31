import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_study/collisions/collision_block.dart';
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

    final collisionsLayerObjects =
        level.tileMap.getLayer<ObjectGroup>("Collisions")?.objects ?? [];

    final solidBlocks = collisionsLayerObjects.where((e) => e.class_ == "soild").map(
          (e) => CollisionBlock(
            position: Vector2(e.x, e.y),
            size: Vector2(e.width, e.height),
            isPlatform: false,
          ),
        );
    addAll(solidBlocks);

    final platformBlocks = collisionsLayerObjects.where((e) => e.class_ == "Platform").map(
          (e) => CollisionBlock(
        position: Vector2(e.x, e.y),
        size: Vector2(e.width, e.height),
        isPlatform: false,
      ),
    );
    addAll(platformBlocks);
    add(
      PlayerComponent(
        player: playerModel,
        collisionBlocks: [...platformBlocks, ...solidBlocks],
        position: Vector2(playerSpawnPoint.x, playerSpawnPoint.y),
      ),
    );

    return super.onLoad();
  }
}
