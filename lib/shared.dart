library shared;

import 'dart:math';

import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:vector_math/vector_math.dart';
export 'package:vector_math/vector_math.dart';

part 'src/shared/components.dart';

//part 'src/shared/systems/name.dart';
part 'src/shared/systems/logic.dart';

Random random = new Random();
Color randomColor() => new Color(random.nextInt(255), 50 + random.nextDouble() * 50, 50 + random.nextDouble());
