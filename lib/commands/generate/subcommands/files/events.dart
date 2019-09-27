String content(String className, String sufix) {
  return'abstract class '+ className + sufix +'Event {}';
}

String splashContent(String className, String sufix) {
  return
  'import \'package:flutter/material.dart\';\n' +
  'abstract class '+ className + sufix +'Event {}\n' +
  '\n' +
  'class SPLASH_INIT_STATE extends '+ className + sufix +'Event {\n' +
  '  BuildContext context;\n' +
  '  SPLASH_INIT_STATE(this.context);\n' +
  '}';
}