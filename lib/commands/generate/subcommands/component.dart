import 'package:args/command_runner.dart';

class GenerateComponent extends Command {

  //-- Singleton
  GenerateComponent._privateConstructor() {
    // Add parser options or flag here
  }

  static final GenerateComponent instance = GenerateComponent._privateConstructor();

  @override
  String get description => 'Create component files and boilerplate code.';

  @override
  String get name => 'component';

  void run() {
    print('################');
    print('Genereate component here');
    print('################');
  }
  
}