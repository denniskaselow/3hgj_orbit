part of shared;


class Transform extends Component {
  Vector2 pos;
  Transform(num x, num y): pos = new Vector2(x.toDouble(), y.toDouble());
}

class Mass extends Component {
  double mass;
  Mass(num mass): this.mass = mass.toDouble();
}

class Radius extends Component {
  double radius;
  Radius(num radius): this.radius = radius.toDouble();
}

class Acceleration extends Component {
  Vector2 acceleration;
  Acceleration(): this.acceleration = new Vector2.zero();
}

class Velocity extends Component {
  Vector2 velocity;
  Velocity(): this.velocity = new Vector2.zero();
  Velocity.of(num x, num y): velocity = new Vector2(x.toDouble(), y.toDouble());
}
