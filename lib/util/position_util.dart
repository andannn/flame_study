import 'package:flame/components.dart';
import 'package:flame/extensions.dart';

extension PositionComponentEx on PositionComponent {
  Rect get rect => scale.x > 0
      ? Rect.fromLTRB(
          position.x,
          position.y,
          position.x + width,
          position.y + height,
        )
      : Rect.fromLTRB(
          position.x - width,
          position.y,
          position.x,
          position.y + height,
        );

  double get left => scale.x > 0 ? position.x : position.x - width;

  double get right => scale.x > 0 ? position.x + width : position.x;

  double get top => position.y;

  double get bottom => position.y + height;
}
