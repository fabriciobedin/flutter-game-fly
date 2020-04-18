import 'package:flame/sprite.dart';
import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/game_loop.dart';

class MachoFly extends Fly {
  MachoFly(GameLoop gameLoop, double x, double y) : super(gameLoop, x, y) {
    flyingSprite = List<Sprite>();
    flyingSprite.add(Sprite("flies/macho-fly-1.png"));
    flyingSprite.add(Sprite("flies/macho-fly-2.png"));
    deadSprite = Sprite("files/macho-fly-dead.png");
  }
}