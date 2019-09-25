String content(String className, String sufix) {
  return
  'import \'package:flutter/widgets.dart\';\n' +
  '\n' +
  'class ' + className + sufix + ' {\n' +
  '\n' +
  '  // Properties  \n' +
  '\n' +
  '  // Functions \n' +
  '  ' + className + sufix + '._privateConstructor();\n' +
  '\n' +
  '  static final ' + className + sufix + ' instance = ' + className + sufix + '._privateConstructor();\n' +
  '\n' +
  '  bool canActivate(BuildContext context) {\n' +
  '    return true;\n' +
  '  }\n' +
  '\n' +
  '}\n';
}
