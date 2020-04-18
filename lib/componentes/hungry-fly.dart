import 'package:flame/sprite.dart';
import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/game_loop.dart';

class HungryFly extends Fly {
  HungryFly(GameLoop gameLoop, double x, double y) : super(gameLoop, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/hungry-fly-1.png"));
    flyingSprite.add(Sprite("flies/hungry-fly-2.png"));
    deadSprite = Sprite("files/hungry-fly-dead.png");
  }
}