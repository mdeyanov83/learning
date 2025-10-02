import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mynotes/helpers/loading/loading_screen_controller.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  LoadingScreenController? controller;

  LoadingScreenController showOverlay({
    required BuildContext context,
    required String text,
  }) {

    final _text = StreamController<String>();
    _text.add(text);

    final state = Overlay.of(context);

  }

}
