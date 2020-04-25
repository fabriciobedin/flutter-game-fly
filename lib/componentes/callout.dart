import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/view.dart';

class Callout {
  final Fly fly;
  Rect rect;
  Sprite sprite;
  double value;

  TextPainter tp;
  TextStyle textStyle;
  Offset textOffset;

  Callout(this.fly) {
    sprite = Sprite('ui/callout.png');
    value = 1;
    tp = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textStyle = TextStyle(
      color: Color(0xff000000),
      fontSize: 15,
    );
  }

  void render(Canvas c) {
    sprite.renderRect(c, rect);
    tp.paint(c, textOffset);
  }

  void update(double t) {
    if (fly.gameLoop.activeView == View.playing) {
      value = value - .25 * t;
      if (value <= 0) {
        fly.gameLoop.activeView = View.lost;
      }
    }

    rect = Rect.fromLTWH(
      fly.flyRect.left - (fly.gameLoop.tileSize * .25),
      fly.flyRect.top - (fly.gameLoop.tileSize * .5),
      fly.gameLoop.tileSize * .75,
      fly.gameLoop.tileSize * .75,
    );

    tp.text = TextSpan(
      text: (value * 50).toInt().toString(),
      style: textStyle,
    );
    tp.layout();
    textOffset = Offset(
      rect.center.dx - (tp.width / 2),
      rect.top + (rect.height * .4) - (tp.height / 2),
    );
  }
}