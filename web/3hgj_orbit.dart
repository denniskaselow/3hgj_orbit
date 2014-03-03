import 'package:3hgj_orbit/client.dart';

@MirrorsUsed(targets: const [RenderingSystem
                            ])
import 'dart:mirrors';

void main() {
  new Game().start();
}

class Game extends GameBase {

  Game() : super.noAssets('3hgj_orbit', 'canvas', 800, 600);

  void createEntities() {
    addEntity([new Transform(100, 100, 0), new Radius(10)]);
    addEntity([new Transform(200, 200, 0), new Radius(15)]);
  }

  List<EntitySystem> getSystems() {
    return [
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

