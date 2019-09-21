String content(String className, String sufix, bool isStateful) {
  
  String _stateful = 
  'class '+ className + sufix +' extends StatefulWidget {\n' +
  '  '+ className + sufix + '({Key key}) : super(key: key);\n' +
  '\n' +
  '  _'+ className + sufix +'State createState() => _'+ className + sufix +'State();\n' +
  '}'+
  '\n' +
  'class _'+ className + sufix +'State extends State<'+ className + sufix +'> {\n' +
  '  @override\n' +
  '  Widget build(BuildContext context) { \n' +
  '    return Container(\n'+
  '      child: Text(\''+ className + sufix +'\'),\n' +
  '    );\n'+
  '  }\n' +
  '};';



  String _stateless = 
  'import package:flutter/widgets.dart.\n' +
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
  '};';


  return isStateful ? _stateful : _stateless;
}