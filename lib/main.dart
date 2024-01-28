import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  SpriteComponent girl = SpriteComponent();

  @override
  FutureOr<void> onLoad() async {
    print("Screen size is $size");

    girl
      ..sprite = await loadSprite("image.png")
      ..size = Vector2(100, 100)
      ..y = 100;

    add(girl);
  }

  @override
  void update(double dt) {
    super.update(dt);

  }
}
