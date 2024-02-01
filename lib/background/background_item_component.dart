import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_study/pixel_adventure.dart';

class BackgroundItemComponent extends SpriteComponent
    with HasGameRef<PixelAdventure> {
  BackgroundItemComponent({required this.color, super.position, super.size});

  final String color;

  @override
  FutureOr<void> onLoad() async {
    priority = -1;
    sprite = Sprite(game.images.fromCache("Background/$color.png"));
    return super.onLoad();
  }
}
