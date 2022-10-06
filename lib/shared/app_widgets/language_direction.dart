import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hassel/core/app_business_logic/app_cubit/app_cubit.dart';


class LanguageDirection extends StatelessWidget {
  final Widget child;
  const LanguageDirection({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      double transformY = !AppCubit.get(context).isArSelected ? 0 : math.pi;
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(transformY),
        child: child,
      );
    });
  }
}
