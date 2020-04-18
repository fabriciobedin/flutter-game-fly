import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';

import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/componentes/racket.dart';

class GameLoop extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  List<Racket> leftRacket;
  List<Racket> rightRacket;
  Random rnd;

  GameLoop(){
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
//    leftRacket = List<Racket>();
//    rightRacket = List<Racket>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    spawnFly();
//    loadRackets();
  }

//  void loadRackets(){
//    leftRacket.add(Racket(this, 0, 500));
//    rightRacket.add(Racket(this, (screenSize.width - tileSize / 2), 50));
//  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);

    flies.add(Fly(this, x, y));
  }

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    canvas.drawRect(bgRect, bgPaint);

//    leftRacket.forEach((leftRacket) {
//      leftRacket.render(canvas);
//    });
//
//    rightRacket.forEach((rightRacket) {
//      rightRacket.render(canvas);
//    });

    flies.forEach((fly) {
      fly.render(canvas);
    });

  }

  void update(double t){
    flies.forEach((fly) {
      fly.update(t);
    });

//    leftRacket.forEach((leftRacket) {
//      leftRacket.update(t);
//    });
//
//    rightRacket.forEach((rightRacket) {
//      rightRacket.update(t);
//    });
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