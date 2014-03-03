part of shared;


class Transform extends Component {
  Vector2 pos;
  Transform(num x, num y): pos = new Vector2(x.toDouble(), y.toDouble());
}

class Mass extends Component {
  double mass;
  Mass(num mass): mass = mass.toDouble();
}

class Radius extends Component {
  double radius;
  Radius(num radius): radius = radius.toDouble();
}

class Acceleration extends Component {
  Vector2 acceleration;
  Acceleration(): acceleration = new Vector2.zero();
}

class Velocity extends Component {
  Vector2 velocity;
  Velocity(): this.velocity = new Vector2.zero();
  Velocity.of(num x, num y): velocity = new Vector2(x.toDouble(), y.toDouble());
}

class Color extends Component {
  int hue;
  double saturation, lightness;
  Color(this.hue, num saturation, num lightness)
      : saturation = saturation.toDouble(),
        lightness = lightness.toDouble();
}
