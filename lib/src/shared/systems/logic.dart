part of shared;


class GravitySystem extends EntitySystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<Mass> mm;
  ComponentMapper<Acceleration> am;

  GravitySystem(): super(Aspect.getAspectForAllOf([Transform, Mass,
      Acceleration]));

  @override
  void processEntities(ReadOnlyBag<Entity> entitiesInBag) {
    var entities = new List<Entity>();
    entitiesInBag.forEach((entity) => entities.add(entity));
    for (int i = 0; i < entities.length - 1; i++) {
      var entity1 = entities[i];
      Transform t1 = tm.get(entity1);
      Mass m1 = mm.get(entity1);
      Acceleration a1 = am.get(entity1);
      for (int j = i + 1; j < entities.length; j++) {
        var entity2 = entities[j];
        Transform t2 = tm.get(entity2);
        Mass m2 = mm.get(entity2);
        Acceleration a2 = am.get(entity2);
        var distSq = t1.pos.distanceToSquared(t2.pos);
        var force = 0.01 * m1.mass * m2.mass / distSq;
        a1.acceleration = (t2.pos - t1.pos) * force/m1.mass;
        a2.acceleration = (t1.pos - t2.pos) * force/m2.mass;
      }
    }
  }

  @override
  bool checkProcessing() => true;
}

class AccelerationSystem extends EntityProcessingSystem {
  ComponentMapper<Acceleration> am;
  ComponentMapper<Velocity> vm;
  AccelerationSystem() : super(Aspect.getAspectForAllOf([Acceleration, Velocity]));

  @override
  void processEntity(Entity entity) {
    var a = am.get(entity);
    var v = vm.get(entity);
    v.velocity += a.acceleration;
  }
}

class MovementSystem extends EntityProcessingSystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<Velocity> vm;
  MovementSystem() : super(Aspect.getAspectForAllOf([Velocity, Transform]));

  @override
  void processEntity(Entity entity) {
    var v = vm.get(entity);
    var t = tm.get(entity);
    t.pos += v.velocity;
  }
}