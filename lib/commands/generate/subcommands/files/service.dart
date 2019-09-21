String content(String className, String sufix) {
  return
  'class ' + className + sufix +' {\n' +
  '\n' +
  ' // Properties \n' +
  '\n' +
  ' // Functions \n' +
  ' '+ className + sufix +'._privateConstructor();\n'+
  '\n' +
  ' static final '+className + sufix +' instance = '+ className + sufix +'._privateConstructor();\n' +
  '}';
}