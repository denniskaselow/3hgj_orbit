part of shared;


class Transform extends Component {
  Vector3 pos;
  Transform(num x, num y): pos = new Vector3(x.toDouble(), y.toDouble(), 0.0);
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
  Vector3 acceleration;
  Acceleration(): this.acceleration = new Vector3.zero();
}

class Velocity extends Component {
  Vector3 velocity;
  Velocity(): this.velocity = new Vector3.zero();
  Velocity.of(num x, num y): velocity = new Vector3(x.toDouble(), y.toDouble(),
      0.0);
}
