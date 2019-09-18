import 'package:args/command_runner.dart';

class GenerateModel extends Command {

  //-- Singleton
  GenerateModel._privateConstructor() {
    // Add parser options or flag here
  }

  static final GenerateModel instance = GenerateModel._privateConstructor();

  @override
  // TODO: implement description
  String get description => 'Create model files and boilerplate code.';

  @override
  // TODO: implement name
  String get name => 'model';

  Future<bool> run() {
    print('################');
    print('Genereate model here');
    print('################');
  }
  
}