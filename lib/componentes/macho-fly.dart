import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/game_loop.dart';

class MachoFly extends Fly {
  double get speed => gameLoop.tileSize * 2.5;

  MachoFly(GameLoop gameLoop, double x, double y) : super(gameLoop) {
    flyRect = Rect.fromLTWH(x, y, gameLoop.tileSize * 1.35, gameLoop.tileSize * 1.35);
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/macho-fly-1.png"));
    flyingSprite.add(Sprite("flies/macho-fly-2.png"));
    deadSprite = Sprite("flies/macho-fly-dead.png");
  }
}