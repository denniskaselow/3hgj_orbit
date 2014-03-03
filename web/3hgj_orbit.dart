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
    addEntity([new Transform(400, 300), new Radius(25), new Mass(1500), new Acceleration(), new Velocity(), new Color(60, 100, 75)]);
  }

  List<EntitySystem> getSystems() {
    return [
            new CollisionDetectionSystem(),
            new CollisionHandlingSystem(),
            new GravitySystem(),
            new AccelerationSystem(),
            new MovementSystem(),
            new CanvasCleaningSystem(canvas, fillStyle: 'black'),
            new RenderingSystem(canvas),
            new FpsRenderingSystem(ctx),
            new CircleSpawnerSystem(canvas)
    ];
  }

  Future onInit() {
  }

  Future onInitDone() {
  }

}

