import 'dart:ui';

import 'package:fluttergamefly/game_loop.dart';

class Racket {
  Rect racketRect;
  Paint racketPaint;
  double x, y;
  final GameLoop gameLoop;
  int direction = 1;

  Racket(this.gameLoop, this.x, this.y){
    racketRect = Rect.fromLTWH(x, y, (gameLoop.tileSize / 2), (gameLoop.tileSize * 2));
    racketPaint = Paint();
    racketPaint.color = Color(0xff6ab04c);
  }

  void render(Canvas canvas){
    canvas.drawRect(racketRect, racketPaint);

  }
  void update(double) {
    y += 10 * direction;

    if(y > gameLoop.screenSize.height-(gameLoop.tileSize * 2)) {
      direction *= -1;
    }

    if (y < 0) {
      direction *= -1;
    }

    racketRect = Rect.fromLTWH(x, y, (gameLoop.tileSize / 2), (gameLoop.tileSize * 2));
  }
}