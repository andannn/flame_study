import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';

class CollisionBlock extends PositionComponent {
  CollisionBlock({
    required this.isPlatform,
    Vector2? position,
    Vector2? size,
  }): super(position: position, size: size) {
    debugMode = kDebugMode;
  }

  final bool isPlatform;
}
