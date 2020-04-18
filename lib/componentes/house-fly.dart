import 'package:flame/sprite.dart';
import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/game_loop.dart';

class HouseFly extends Fly {
  HouseFly(GameLoop gameLoop, double x, double y) : super(gameLoop, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/house-fly-1.png"));
    flyingSprite.add(Sprite("flies/house-fly-2.png"));
    deadSprite = Sprite("files/house-fly-dead.png");
  }
}