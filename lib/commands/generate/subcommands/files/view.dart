String content(String className, String sufix, String projectName, bool isComponent, String fileName, {bool isStateful = true}) {
  
  String _stateful = 
  'import \'package:flutter/material.dart\';\n' +
  'import \'package:flutter/widgets.dart\';\n' +
  'import \'package:' + projectName + '/' + (isComponent ? 'components' : 'pages') + '/' + fileName + '/' + fileName + '.bloc.dart\';\n' +
  '\n' +
  'class '+ className + sufix +' extends StatefulWidget {\n' +
  '  '+ className + sufix + '({Key key}) : super(key: key);\n' +
  '\n' +
  '  _'+ className + sufix +'State createState() => _'+ className + sufix +'State();\n' +
  '}\n'+
  '\n' +
  'class _'+ className + sufix +'State extends State<'+ className + sufix +'> {\n' +
  '\n' +
  '  '+ className + sufix + 'Bloc _bloc = '+ className + sufix + 'Bloc();\n' +
  '\n' +
  '  @override\n' +
  '  void dispose() { \n' +
  '    this._bloc.dispose();\n'+
  '    super.dispose();\n'+
  '  }\n' +
  '\n' +
  '  @override\n' +
  '  Widget build(BuildContext context) { \n' +
  '    return Scaffold(\n' +
  '      body: Container(\n' +
  '        color: Colors.white,\n' +
  '        child: Center(\n' +
  '          child: Text(\''+ className + sufix +'\'),\n' +
  '        ),\n' +
  '      )\n'+
  '    );\n'+
  '  }\n' +
  '}';



  String _stateless = 
  'import \'package:flutter/widgets.dart\';\n' +
  '\n' +
  '\n' +
  'class ' + className +  sufix +' extends StatelessWidget {\n'+
  '  const '+ className +  sufix +'({Key key}) : super(key: key);\n' +
  '\n' +
  '  @override\n' +
  '  Widget build(BuildContext context) { \n' +
  '    return Scaffold(\n' +
  '      body: Container(\n' +
  '        color: Colors.white,\n' +
  '        child: Center(\n' +
  '          child: Text(\''+ className + sufix +'\'),\n' +
  '        ),\n' +
  '      )\n'+
  '    );\n'+
  '  }\n' +
  '}';


  return isStateful ? _stateful : _stateless;
}

String splashContent(String className, String sufix, String projectName, String fileName,) {
  return
  'import \'package:flutter/material.dart\';\n' +
  'import \'package:flutter/widgets.dart\';\n' +
  'import \'package:' + projectName + '/pages/' + fileName + '/' + fileName + '.bloc.dart\';\n' +
  'import \'package:' + projectName + '/pages/' + fileName + '/' + fileName + '.events.dart\';\n' +
  'import \'package:' + projectName + '/common/assets.dart\' as ASSETS;\n' +
  '\n' +
  'class '+ className + sufix +' extends StatefulWidget {\n' +
  '  '+ className + sufix + '({Key key}) : super(key: key);\n' +
  '\n' +
  '  _'+ className + sufix +'State createState() => _'+ className + sufix +'State();\n' +
  '}'+
  '\n' +
  'class _'+ className + sufix +'State extends State<'+ className + sufix +'> {\n' +
  '\n' +
  '  '+ className + sufix + 'Bloc _bloc = '+ className + sufix + 'Bloc();\n' +
  '\n' +
  '  @override\n' +
  '  void initState() {\n' +
  '    this._bloc.eventSink.add(SPLASH_INIT_STATE(context));\n' +
  '    super.initState();\n' +
  '  }\n' +
  '\n' +
  '  @override\n' +
  '  void dispose() { \n' +
  '    this._bloc.dispose();\n'+
  '    super.dispose();\n'+
  '  }\n' +
  '\n' +
  '  @override\n' +
  '  Widget build(BuildContext context) { \n' +
  '    return Scaffold(\n' +
  '      body: Container(\n' +
  '        color: Colors.white,\n' +
  '        child: Center(\n' +
  '          child: Image.asset(\n' +
  '            ASSETS.logo,\n' +
  '            height: 150.0,\n' +
  '            width: 150.0,\n' +
  '          ),\n' +
  '        ),\n' +
  '      )\n'+
  '    );\n'+
  '  }\n' +
  '}';
}