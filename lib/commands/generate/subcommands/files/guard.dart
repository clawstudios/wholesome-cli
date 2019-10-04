String content(String className, String sufix) {
  return
  'import \'package:flutter/widgets.dart\';\n' +
  '\n' +
  'mixin ' + className + sufix + ' {\n' +
  '\n' +
  '  bool canActivate(BuildContext context) {\n' +
  '    return true;\n' +
  '  }\n' +
  '\n' +
  '}\n';
}