import 'package:flame/cache.dart';
import 'package:flame/components.dart';

class NinjaFrogRes extends PlayerResource {
  @override
  final basePath = 'Main Characters/Ninja Frog/';
}

class MaskDudeRes extends PlayerResource {
  @override
  final basePath = 'Main Characters/Mask Dude/';
}

enum PlayerAnimationState {
  idle,
  fail,
  hit,
  running,
  jump,
  wallJump,
  doubleJump,
}

class SequencedAnimationResource {
  final int amount;
  final String path;

  SequencedAnimationResource({required this.amount, required this.path});
}

abstract class PlayerResource {
  String get basePath;

  SequencedAnimationResource get doubleJump => SequencedAnimationResource(
        amount: 6,
        path: "${basePath}Double Jump (32x32).png",
      );

  SequencedAnimationResource get fail => SequencedAnimationResource(
        amount: 1,
        path: "${basePath}Fall (32x32).png",
      );

  SequencedAnimationResource get hit => SequencedAnimationResource(
        amount: 7,
        path: "${basePath}Hit (32x32).png",
      );

  SequencedAnimationResource get idle => SequencedAnimationResource(
        amount: 11,
        path: "${basePath}Idle (32x32).png",
      );

  SequencedAnimationResource get jump => SequencedAnimationResource(
        amount: 1,
        path: "${basePath}Jump (32x32).png",
      );

  SequencedAnimationResource get run => SequencedAnimationResource(
        amount: 12,
        path: "${basePath}Run (32x32).png",
      );

  SequencedAnimationResource get wallJump => SequencedAnimationResource(
        amount: 5,
        path: "${basePath}Wall Jump (32x32).png",
      );
}


extension PlayerStateWithResource on PlayerResource {
  static const double stepTime = 0.05;

  Map<PlayerAnimationState, SpriteAnimation> getAnimationMap(Images images) => {
        PlayerAnimationState.idle: createSpriteAnimation(images, idle),
        PlayerAnimationState.running: createSpriteAnimation(images, run),
        PlayerAnimationState.fail: createSpriteAnimation(images, fail),
        PlayerAnimationState.hit: createSpriteAnimation(images, hit),
        PlayerAnimationState.jump: createSpriteAnimation(images, jump),
        PlayerAnimationState.wallJump: createSpriteAnimation(images, wallJump),
        PlayerAnimationState.doubleJump:
            createSpriteAnimation(images, doubleJump),
      };

  SpriteAnimation createSpriteAnimation(
          Images images, SequencedAnimationResource resource) =>
      SpriteAnimation.fromFrameData(
        images.fromCache(resource.path),
        SpriteAnimationData.sequenced(
          amount: resource.amount,
          stepTime: stepTime,
          textureSize: Vector2.all(32),
        ),
      );
}

