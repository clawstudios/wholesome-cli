String content(String className, String sufix, String projectName, bool isComponent, String fileName, {bool isStateful = true}) {
  
  String _stateful = 
  'import \'package:flutter/widgets.dart\';\n' +
  'import \'package:' + projectName + '/' + (isComponent ? 'components' : 'pages') + '/' + fileName + '/' + fileName + '.bloc.dart\';\n' +
  '\n' +
  'class '+ className + sufix +' extends StatefulWidget {\n' +
  '  '+ className + sufix + '({Key key}) : super(key: key);\n' +
  '\n' +
  '  _'+ className + sufix +'State createState() => _'+ className + sufix +'State();\n' +
  '}'+
  '\n' +
  'class _'+ className + sufix +'State extends State<'+ className + sufix +'> {\n' +
  '\n' +
  '  '+ className + sufix + 'Bloc _bloc = '+ className + sufix + 'Bloc.instance;\n' +
  '\n' +
  '  @override\n' +
  '  void dispose() { \n' +
  '    this._bloc.dispose();\n'+
  '    super.dispose();\n'+
  '  }\n' +
  '\n' +
  '  @override\n' +
  '  Widget build(BuildContext context) { \n' +
  '    return Container(\n'+
  '      child: Text(\''+ className + sufix +'\'),\n' +
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
  '    return Container(\n'+
  '      child: Text(\''+ className + sufix +'\'),\n' +
  '    );\n'+
  '  }\n' +
  '}';


  return isStateful ? _stateful : _stateless;
}