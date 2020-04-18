import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttergamefly/componentes/agile-fly.dart';
import 'package:fluttergamefly/componentes/backyard.dart';
import 'package:fluttergamefly/componentes/drooler-fly.dart';
import 'dart:ui';

import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/componentes/house-fly.dart';
import 'package:fluttergamefly/componentes/hungry-fly.dart';
import 'package:fluttergamefly/componentes/macho-fly.dart';

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
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.0));
    double y = rnd.nextDouble() * (screenSize.height - (tileSize * 2.0));

    switch(rnd.nextInt(5)){
      case 0:
        flies.add(AgileFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(HouseFly(this, x, y));
        break;
      case 3:
        flies.add(HungryFly(this, x, y));
        break;
      case 4:
        flies.add(MachoFly(this, x, y));
        break;
    }


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
      if (fly.flyRect.contains(details.globalPosition) && !fly.isDead){
        fly.onTapDown();
        spawnFly();
      }
    });

    flies.removeWhere((fly) => fly.isOffScreen);
  }
}