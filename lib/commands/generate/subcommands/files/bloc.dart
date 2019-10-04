String content(String className, String sufix, String fileName, String projectName, String defaultFolder, {String fileFolder}) {
  
  String bloc =
  'import \'dart:async\';\n';
  if (fileFolder != null) {
    bloc += 
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileFolder + '/' + fileName + '/' + fileName + '.events.dart\';\n' +
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileFolder + '/' + fileName + '/' + fileName + '.state.dart\';\n';
  } else {
    bloc += 
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileName + '/' + fileName + '.events.dart\';\n' +
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileName + '/' + fileName + '.state.dart\';\n' ;
  }

  bloc +=
  '\n' +
  'class '+ className + sufix +'Bloc {\n' +
  '\n' +
  '  //-- Properties\n' +
  '  '+ className + sufix +'State _state = '+ className + sufix +'State();\n' +
  '\n' +
  '  //-- BLoC Properties\n' +
  '  final _stateController = StreamController<'+ className + sufix +'State>();\n' +
  '  final _eventController = StreamController<'+ className + sufix +'Event>.broadcast();\n' +
  '\n' +
  '  //-- BLoC Methods\n' +
  '  StreamSink<'+ className + sufix +'State> get _stateSink => _stateController.sink;\n' +
  '  Stream<'+ className + sufix +'State> get state => _stateController.stream;\n' +
  '\n' +
  '  Sink<'+ className + sufix +'Event> get eventSink => _eventController.sink;\n' +
  '\n' +
  '  //-- Singleton\n' +
  '  '+ className + sufix +'Bloc() {\n' +
  '    this._eventController.stream.listen(processEvent);\n' +
  '  }\n' +
    '\n' +
  '  //-- Methods\n' +
  '  // Process Event\n' +
  '  void processEvent('+ className + sufix +'Event event) {\n' +
  '    // Process you custom events defined in .events.dart\n' +
  '  }\n' +
  '\n' +
  '  // Dispose\n' +
  '  void dispose() {\n' +
  '    this._stateController.close();\n' +
  '    this._eventController.close();\n' +
  '  }\n' +
  '\n' +
  '  // add to stream in\n' +
  '  void updateState() {\n' +
  '    this._stateSink.add(this._state);\n' +
  '  }\n' +
  '\n' +
  '}\n';

  return bloc;

}

String splashContent(String className, String sufix, String fileName, String projectName, String defaultFolder, {String fileFolder}) {
  
  String bloc =
  'import \'dart:async\';\n' +
  'import \'package:flutter/material.dart\';\n';

  if (fileFolder != null) {
    bloc += 
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileFolder + '/' + fileName + '/' + fileName + '.events.dart\';\n' +
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileFolder + '/' + fileName + '/' + fileName + '.state.dart\';\n';
  } else {
    bloc += 
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileName + '/' + fileName + '.events.dart\';\n' +
    'import \'package:'+ projectName +'/'+ defaultFolder + '/' + fileName + '/' + fileName + '.state.dart\';\n' ;
  }

  bloc +=
  '\n' +
  'class '+ className + sufix +'Bloc {\n' +
  '\n' +
  '  //-- Properties\n' +
  '  '+ className + sufix +'State _state = '+ className + sufix +'State();\n' +
  '\n' +
  '  //-- BLoC Properties\n' +
  '  final _stateController = StreamController<'+ className + sufix +'State>();\n' +
  '  final _eventController = StreamController<'+ className + sufix +'Event>.broadcast();\n' +
  '\n' +
  '  //-- BLoC Methods\n' +
  '  StreamSink<'+ className + sufix +'State> get _stateSink => _stateController.sink;\n' +
  '  Stream<'+ className + sufix +'State> get state => _stateController.stream;\n' +
  '\n' +
  '  Sink<'+ className + sufix +'Event> get eventSink => _eventController.sink;\n' +
  '\n' +
  '  //-- Singleton\n' +
  '  '+ className + sufix +'Bloc() {\n' +
  '    this._eventController.stream.listen(processEvent);\n' +
  '  }\n' +
  '\n' +

  '\n' +
  '  //-- Methods\n' +
  '  // Process Event\n' +
  '  void processEvent('+ className + sufix +'Event event) {\n' +
  '    if (event is SPLASH_INIT_STATE) {\n' +
  '      Future.delayed(Duration(seconds: 3)).then((test){\n' +
  '        Navigator.pushNamed(event.context, \'/home\');\n' +
  '      });\n' +
  '    }\n' +
  '  }\n' +
  '\n' +
  '  // Dispose\n' +
  '  void dispose() {\n' +
  '    this._stateController.close();\n' +
  '    this._eventController.close();\n' +
  '  }\n' +
  '\n' +
  '  // add to stream in\n' +
  '  void updateState() {\n' +
  '    this._stateSink.add(this._state);\n' +
  '  }\n' +
  '\n' +
  '}\n';

  return bloc;

}