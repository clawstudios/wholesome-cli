String content(String projectName) {
  return
  'import \'package:flutter\/material.dart\';\n' +
  'import \'package:'+ projectName.toLowerCase() +'\/common\/routes.dart\'; \/\/ ROUTES\n' +
  '\n' +
  'void main() => runApp(MyApp());' +
  '\n' +
  '\n' +
  '\n' +
  '\n' +
  'class MyApp extends StatelessWidget {\n' +
  '  \/\/ This widget is the root of your application.\n' +
  '  @override\n' +
  '  Widget build(BuildContext context) {\n' +
  '    return MaterialApp(\n' +
  '      title: \''+ projectName +'\',\n' +
  '      initialRoute: \'\/\',\n' +
  '      routes: ROUTES,\n' +
  '      theme: ThemeData(),\n' +
  '    );\n' +
  '  }\n' +
  '}';
}

