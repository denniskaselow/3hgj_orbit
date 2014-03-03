part of client;


class CircleSpawnerSystem extends VoidEntitySystem {
  CanvasElement canvas;
  Point sp, ep;
  CircleSpawnerSystem(this.canvas);

  @override
  void initialize() {
    canvas.onMouseDown.listen((event) {
      sp = event.offset;
    });
    canvas.onMouseUp.listen((event) {
      ep = event.offset;
    });
  }

  @override
  void processSystem() {
    Point delta = ep - sp;
    world.createAndAddEntity([new Transform(sp.x, sp.y), new Radius(10), new Mass(10), new Acceleration(), new Velocity.of(delta.x / 10, delta.y / 10), randomColor()]);
  }

  @override
  void end() {
    sp = null;
    ep = null;
  }

  bool checkProcessing() => sp != null && ep != null;
}
