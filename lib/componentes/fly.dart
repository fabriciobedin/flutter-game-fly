import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:fluttergamefly/game_loop.dart';

class Fly {
  Rect flyRect;
  final GameLoop gameLoop;
  bool isDead = false;
  bool isOffScreen = false;

  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;

  Fly(this.gameLoop, double x, double y){
    flyRect = Rect.fromLTWH(x, y, gameLoop.tileSize, gameLoop.tileSize);
  }

  void render(Canvas canvas){
    if(isDead){
      deadSprite.renderRect(canvas, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(canvas, flyRect.inflate(2));
    }
  }
  
  void update(double time) {
    if(isDead) {
      flyRect = flyRect.translate(0, gameLoop.tileSize * 12 * time);
      if(flyRect.top > gameLoop.screenSize.height) {
        isOffScreen = true;
      }
    } else {
      flyingSpriteIndex += 30 * time;
      if(flyingSpriteIndex >= flyingSprite.length){
        flyingSpriteIndex -= flyingSprite.length;
      }
    }
  }

  void onTapDown() {
    isDead = true;
  }
}