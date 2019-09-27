String content(String projectName) {
  return
  'import \'package:flutter/material.dart\'; \n' +
  'import \'package:'+ projectName.toLowerCase() +'/pages/home/home.view.dart\'; \n' +
  'import \'package:'+ projectName.toLowerCase() +'/pages/splash/splash.view.dart\'; \n' +
  '\n' +
  'Map<String, WidgetBuilder> ROUTES = { \n' +
  '  \'/\': (context) => SplashPage(),\n' +
  '  \'/home\': (context) => HomePage(),\n' +
  '};';
}