import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttergamefly/componentes/backyard.dart';
import 'dart:ui';

import 'package:fluttergamefly/componentes/fly.dart';

class GameLoop extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  Backyard backyard;

  GameLoop(){
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    backyard = Backyard(this);
    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);

    flies.add(Fly(this, x, y));
  }

  void render(Canvas canvas) {
    backyard.render(canvas);
  
    flies.forEach((fly) {
      fly.render(canvas);
    });

  }

  void update(double t){
    flies.forEach((fly) {
      fly.update(t);
    });
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails details) {
    flies.forEach((fly) {
      if (fly.flyRect.contains(details.globalPosition)){
        fly.onTapDown();
        spawnFly();
      }
    });

    flies.removeWhere((fly) => fly.isOffScreen);
  }
}