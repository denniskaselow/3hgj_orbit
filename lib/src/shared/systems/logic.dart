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

class CollisionDetectionSystem extends EntitySystem {
  ComponentMapper<Transform> tm;
  ComponentMapper<Radius> rm;
  CollisionHandlingSystem chs;
  CollisionDetectionSystem() : super(Aspect.getAspectForAllOf([Transform, Radius]));

  @override
  void processEntities(ReadOnlyBag<Entity> entitiesInBag) {
    var entities = new List<Entity>();
    entitiesInBag.forEach((entity) => entities.add(entity));
    for (int i = 0; i < entities.length - 1; i++) {
      var entity1 = entities[i];
      Transform t1 = tm.get(entity1);
      Radius r1 = rm.get(entity1);
      for (int j = i + 1; j < entities.length; j++) {
        var entity2 = entities[j];
        Transform t2 = tm.get(entity2);
        Radius r2 = rm.get(entity2);
        if (t2.pos.distanceToSquared(t1.pos) < r1.radius * r1.radius + r2.radius * r2.radius) {
          chs.collisions.add(new Collision(entity1, entity2));
        }
      }
    }
  }

  @override
  bool checkProcessing() => true;
}

class CollisionHandlingSystem extends VoidEntitySystem {
  var collisions = new List<Collision>();
  ComponentMapper<Mass> mm;
  ComponentMapper<Velocity> vm;
  ComponentMapper<Transform> tm;

  @override
  void processSystem() {
    // there will probably be weird behavior if one entity collides with
    // mutliple entities in the same frame
    collisions.forEach((collision) {
      Transform t1 = tm.get(collision.entity1);
      Transform t2 = tm.get(collision.entity2);
      Mass m1 = mm.get(collision.entity1);
      Mass m2 = mm.get(collision.entity2);
      Velocity v1 = vm.get(collision.entity1);
      Velocity v2 = vm.get(collision.entity2);

      num dx = t2.pos.x - t1.pos.x;
      num dy = t2.pos.y - t1.pos.y;
      // collision angle
      num phi = atan2(dy, dx);

      num v1i = v1.velocity.length;
      num v2i = v2.velocity.length;

      num ang1 = atan2(v1.velocity.y, v1.velocity.x);
      num ang2 = atan2(v2.velocity.y, v2.velocity.x);

      // transforming velocities in a coordinate system where both circles
      // have an equal y-coordinate thus allowing 1D elastic collision calculations
      num v1xr = v1i * cos(ang1 - phi);
      num v1yr = v1i * sin(ang1 - phi);
      num v2xr = v2i * cos(ang2 - phi);
      num v2yr = v2i * sin(ang2 - phi);

      // calculate momentums
      num p1 = v1xr * m1.mass;
      num p2 = v2xr * m2.mass;
      num mTotal = m1.mass + m2.mass;

      // elastic collision
      num v1fxr = (p1 + 2 * p2 - m2.mass * v1xr) / mTotal;
      num v2fxr = (p2 + 2 * p1 - m1.mass * v2xr) / mTotal;
      num v1fyr = v1yr;
      num v2fyr = v2yr;

      // transform back to original coordinate system
      v1.velocity.x = cos(phi) * v1fxr + cos(phi + PI/2) * v1fyr;
      v1.velocity.y = sin(phi) * v1fxr + sin(phi + PI/2) * v1fyr;
      v2.velocity.x = cos(phi) * v2fxr + cos(phi + PI/2) * v2fyr;
      v2.velocity.y = sin(phi) * v2fxr + sin(phi + PI/2) * v2fyr;
    });
  }

  @override
  void end() {
    collisions.clear();
  }

  bool checkProcessing() => collisions.isNotEmpty;
}

class Collision {
  Entity entity1, entity2;
  Collision(this.entity1, this.entity2);
}