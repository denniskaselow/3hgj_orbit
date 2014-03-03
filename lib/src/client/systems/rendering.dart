part of client;


class RenderingSystem extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<Radius> rm;
  ComponentMapper<Color> cm;
  CanvasRenderingContext2D ctx;
  RenderingSystem(CanvasElement canvas)
      : this.ctx = canvas.context2D,
        super(Aspect.getAspectForAllOf([Transform, Radius, Color]));


  @override
  void processEntity(Entity entity) {
    var t = tm.get(entity);
    var r = rm.get(entity);
    var c = cm.get(entity);
    ctx..beginPath()
       ..setFillColorHsl(c.hue, c.saturation, c.lightness)
       ..arc(t.pos.x, t.pos.y, r.radius, 0, FastMath.TWO_PI)
       ..closePath()
       ..fill();
  }
}
