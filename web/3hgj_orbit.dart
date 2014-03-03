import 'package:3hgj_orbit/client.dart';

@MirrorsUsed(targets: const [RenderingSystem, GravitySystem, AccelerationSystem,
                             MovementSystem, CollisionDetectionSystem,
                             CollisionHandlingSystem
                            ])
import 'dart:mirrors';

void main() {
  new Game().start();
}

class Game extends GameBase {

  Game() : super.noAssets('3hgj_orbit', 'canvas', 800, 600);

  void createEntities() {
    addEntity([new Transform(100, 100), new Radius(10), new Mass(10), new Acceleration(), new Velocity.of(1, -1)]);
    addEntity([new Transform(700, 500), new Radius(10), new Mass(10), new Acceleration(), new Velocity.of(-1, 1)]);
    addEntity([new Transform(700, 100), new Radius(10), new Mass(10), new Acceleration(), new Velocity.of(1, 1)]);
    addEntity([new Transform(100, 500), new Radius(10), new Mass(10), new Acceleration(), new Velocity.of(-1, -1)]);
    addEntity([new Transform(400, 300), new Radius(15), new Mass(1500), new Acceleration(), new Velocity()]);
  }

  List<EntitySystem> getSystems() {
    return [
            new CollisionDetectionSystem(),
            new CollisionHandlingSystem(),
            new GravitySystem(),
            new AccelerationSystem(),
            new MovementSystem(),
            new CanvasCleaningSystem(canvas),
            new RenderingSystem(canvas),
            new FpsRenderingSystem(ctx)
    ];
  }

  Future onInit() {
  }

  Future onInitDone() {
  }
}

