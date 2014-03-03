part of client;


class RenderingSystem extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<Radius> rm;
  CanvasRenderingContext2D ctx;
  RenderingSystem(CanvasElement canvas)
      : this.ctx = canvas.context2D,
        super(Aspect.getAspectForAllOf([Transform, Radius]));


  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var r = rm.get(entity);
    ctx..beginPath()
       ..fillStyle = 'black'
       ..arc(t.pos.x, t.pos.y, r.radius, 0, FastMath.TWO_PI)
       ..closePath()
       ..fill();
  }
}
