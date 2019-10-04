String content(String className, String sufix) {
  return
  'import \'package:flutter/widgets.dart\';\n' +
  '\n' +
  'abstract class ' + className + sufix + ' {\n' +
  '\n' +
  '  factory ' + className + sufix + '._() => null;\n' +
    '\n' +
  '  bool canActivate(BuildContext context) {\n' +
  '    return true;\n' +
  '  }\n' +
  '\n' +
  '}\n';
}