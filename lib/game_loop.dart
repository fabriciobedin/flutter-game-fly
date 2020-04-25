import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:fluttergamefly/componentes/agile-fly.dart';
import 'package:fluttergamefly/componentes/backyard.dart';
import 'package:fluttergamefly/componentes/credits-button.dart';
import 'package:fluttergamefly/componentes/drooler-fly.dart';
import 'dart:ui';

import 'package:fluttergamefly/componentes/fly.dart';
import 'package:fluttergamefly/componentes/help-button.dart';
import 'package:fluttergamefly/componentes/house-fly.dart';
import 'package:fluttergamefly/componentes/hungry-fly.dart';
import 'package:fluttergamefly/componentes/macho-fly.dart';
import 'package:fluttergamefly/componentes/start-button.dart';
import 'package:fluttergamefly/controllers/spawner.dart';
import 'package:fluttergamefly/view.dart';
import 'package:fluttergamefly/view/credits-view.dart';
import 'package:fluttergamefly/view/help-view.dart';
import 'package:fluttergamefly/view/home-view.dart';
import 'package:fluttergamefly/view/lost-view.dart';

class GameLoop extends Game {
  View activeView = View.home;
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;

  HomeView homeView;
  LostView lostView;
  HelpView helpView;
  CreditsView creditsView;

  Backyard backyard;

  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;

  FlySpawner spawner;

  GameLoop(){
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());

    spawner = FlySpawner(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);

    backyard = Backyard(this);

    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.0));
    double y = rnd.nextDouble() * (screenSize.height - (tileSize * 2.0));

    switch(rnd.nextInt(5)){
      case 0:
        flies.add(AgileFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(HouseFly(this, x, y));
        break;
      case 3:
        flies.add(HungryFly(this, x, y));
        break;
      case 4:
        flies.add(MachoFly(this, x, y));
        break;
    }
  }

  void render(Canvas canvas) {

    backyard.render(canvas);

    flies.forEach((fly) {
      fly.render(canvas);
    });

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  void update(double t){
    spawner.update(t);

    flies.forEach((fly) {
      fly.update(t);
    });

    flies.removeWhere((fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void onTapDown(TapDownDetails details) {
    // start button
    if (startButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        return;
      }
    }

    //dialog views
    if (activeView == View.help || activeView == View.credits) {
      activeView = View.home;
      return;
    }

    // help button
    if (helpButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        return;
      }
    }

    // credits button
    if (creditsButton.rect.contains(details.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        return;
      }
    }

    bool didHitAFly = false;
    List<Fly>.from(flies).forEach((fly) {
      if (fly.flyRect.contains(details.globalPosition) && !fly.isDead){
        fly.onTapDown();
        didHitAFly = true;
        return;
      }
    });

    if (activeView == View.playing && !didHitAFly) {
      activeView = View.lost;
    }
  }
}