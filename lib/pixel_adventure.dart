import 'dart:async';

import 'package:flame/camera.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flame_study/levels/level.dart';
import 'package:flame_study/player/model/player_model.dart';
import 'package:flame_study/util/logger.dart';

class PixelAdventure extends FlameGame with HasKeyboardHandlerComponents {
  late final CameraComponent cam;
  final World level = Level(playerModel: NinjaFrog());

  @override
  FutureOr<void> onLoad() async {
    // load all images to cache.
    await images.loadAllImages();

    logger.d('size $size');
    cam = CameraComponent.withFixedResolution(
        world: level, width: 640, height: 360);

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([
      cam,
      level,
    ]);

    return super.onLoad();
  }
}
