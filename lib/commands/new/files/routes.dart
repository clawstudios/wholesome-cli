String content(String projectName) {
  return
  'import \'package:flutter/material.dart\'; \n' +
  'import \'package:'+ projectName.toLowerCase() +'/pages/home.view.dart\'; \n' +
  '\n' +
  'Map<String, WidgetBuilder> ROUTES = { \n' +
  '  \'/\': (context) => HomePage(),\n' +
  '};';
}