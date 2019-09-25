String content(String className, String sufix) {
  return
  'import \'dart:convert\'; \n' +
  '\n' +
  'class ' + className + sufix + ' {\n'+ 
  '\n' +
  '  // Ctor\n' +
  '  const ' + className + sufix + '();\n' +
  '\n' +
  '  // From JSON\n'+
  ' ' + className + sufix + '.fromJSON(_json) {\n' +
  '    dynamic data = json.decode(_json);\n' +
  '  }\n' +
  '\n' +
  '  // From Map\n'+
  ' ' + className + sufix + '.fromMap(Map<dynamic, dynamic> data ) {\n'+
  '\n' +
  '  }\n' +
  '\n' +
  '  // To Map\n'+
  '  Map<String, dynamic> toMap() {\n' +
  '    return {\n' +
  '    };\n' +
  '  }\n'
  '\n' +
  '}';
}

