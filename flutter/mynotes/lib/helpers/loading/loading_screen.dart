import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mynotes/helpers/loading/loading_screen_controller.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  LoadingScreenController? controller;

  LoadingScreenController showOverlay({
    required BuildContext: context,
    required text: text,
  }) {

    final _text = StreamController();
    _text.add(text);

    Overlay.of(context)

  }

}
