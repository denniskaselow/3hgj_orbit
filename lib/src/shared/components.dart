part of shared;


class Transform extends Component {
  Vector3 pos;
  Transform(num x, num y, num z): pos = new Vector3(x.toDouble(), y.toDouble(),
      z.toDouble());
}

class Density extends Component {
  double density;
  Density(num density) : this.density = density.toDouble();
}

class Radius extends Component {
  double radius;
  Radius(num radius) : this.radius = radius.toDouble();
}