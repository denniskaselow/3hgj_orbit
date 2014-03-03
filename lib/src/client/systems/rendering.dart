part of client;


class RenderingSystem extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<Radius> rm;
  CanvasRenderingContext2D ctx;
  RenderingSystem(CanvasElement canvas)
      : this.ctx = canvas.context2D,
        super(Aspect.getAspectForAllOf([Radius]));


  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var r = rm.get(entity);
    ctx..fillStyle = 'black'
       ..arc(t.pos.x, t.pos.y, r.radius, 0, FastMath.TWO_PI)
       ..fill();
  }
}
