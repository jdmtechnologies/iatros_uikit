import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double sizeWidth([double? size]) =>
      size != null
          ? MediaQuery.of(this).size.width * size
          : MediaQuery.of(this).size.width;
  double sizeHeight([double? size]) =>
      size != null
          ? MediaQuery.of(this).size.height * size
          : MediaQuery.of(this).size.height;
}
