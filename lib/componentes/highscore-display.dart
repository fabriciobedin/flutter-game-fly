import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:fluttergamefly/game_loop.dart';

class HighscoreDisplay {
  final GameLoop game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  HighscoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    Shadow shadow = Shadow(
      blurRadius: 3,
      color: Color(0xff000000),
      offset: Offset.zero,
    );

    textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 25,
      shadows: [shadow, shadow, shadow, shadow],
    );

    position = Offset.zero;

    updateHighscore();
  }

  void updateHighscore() {
    int highscore = game.storage.getInt('highscore') ?? 0;

    painter.text = TextSpan(
      text: 'High-score: ' + highscore.toString(),
      style: textStyle,
    );

    painter.layout();

    position = Offset(
      game.screenSize.width - (game.tileSize * .25) - painter.width,
      game.tileSize * .75,
    );
  }

  void render(Canvas c) {
    painter.paint(c, position);
  }
}