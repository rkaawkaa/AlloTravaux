import 'package:flutter/material.dart';
import 'style.dart';

BoxDecoration bodyBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomCenter, 
    end: Alignment.topLeft,
    colors: [bodyBackgroundLow, bodyBackgroundHigh]
  )
);

BoxDecoration navBackgroundDecoration = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.bottomCenter, 
    end: Alignment.topLeft,
    colors: [navBackgroundLow, navBackgroundHigh],
  )
);

