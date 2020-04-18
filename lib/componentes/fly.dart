import 'dart:ui';

import 'package:fluttergamefly/game_loop.dart';

class Fly {
  Rect flyRect;
  Paint flyPaint;
  final GameLoop gameLoop;

  Fly(this.gameLoop, double x, double y){
    flyRect = Rect.fromLTWH(x, y, gameLoop.tileSize, gameLoop.tileSize);
    flyPaint = Paint();
    flyPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas canvas){
    canvas.drawRect(flyRect, flyPaint);

  }
  void update(double) {

  }
}