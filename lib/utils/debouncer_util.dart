import 'dart:async';

import 'package:flutter/material.dart';

class DebouncerUtil {
  final int seconds;
  VoidCallback? action;
  Timer? _timer;

  DebouncerUtil({required this.seconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: seconds), action);
  }

  cancel() {
    _timer?.cancel();
  }
}
