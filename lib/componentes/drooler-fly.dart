import 'package:flame/sprite.dart';
import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/game_loop.dart';

class DroolerFly extends Fly {
  DroolerFly(GameLoop gameLoop, double x, double y) : super(gameLoop, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/drooler-fly-1.png"));
    flyingSprite.add(Sprite("flies/drooler-fly-2.png"));
    deadSprite = Sprite("files/drooler-fly-dead.png");
  }
}