import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_study/background/background_item_component.dart';
import 'package:flame_study/pixel_adventure.dart';

class ScrollingBackgroundComponent extends Component
    with HasGameRef<PixelAdventure> {
  ScrollingBackgroundComponent(this.color);

  final String color;

  static const backgroundTiledSize = 64.0;

  @override
  FutureOr<void> onLoad() async {
    priority = -1;

    final columnCount = (game.size.y / backgroundTiledSize).floor();
    final rowCount = (game.size.x / backgroundTiledSize).floor();
    for (double y = 0; y < columnCount; y++) {
      for (double x = 0; x < rowCount; x++) {
        final background = BackgroundItemComponent(
          color: color,
          size: Vector2.all(backgroundTiledSize + 0.6),
          position: Vector2(
            (x * backgroundTiledSize),
            (y * backgroundTiledSize),
          ),
        );
        add(background);
      }
    }

    return super.onLoad();
  }
}
