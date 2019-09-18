import 'package:args/command_runner.dart';

class GenerateComponent extends Command {

  //-- Singleton
  GenerateComponent._privateConstructor() {
    // Add parser options or flag here
  }

  static final GenerateComponent instance = GenerateComponent._privateConstructor();

  @override
  // TODO: implement description
  String get description => 'Create component files and boilerplate code.';

  @override
  // TODO: implement name
  String get name => 'component';

  Future<bool> run() {
    print('################');
    print('Genereate component here');
    print('################');
  }
  
}