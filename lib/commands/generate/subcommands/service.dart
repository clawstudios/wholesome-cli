import 'package:args/command_runner.dart';

class GenerateService extends Command {

  //-- Singleton
  GenerateService._privateConstructor() {
    // Add parser options or flag here
  }

  static final GenerateService instance = GenerateService._privateConstructor();

  @override
  // TODO: implement description
  String get description => 'Create service files and boilerplate code.';

  @override
  // TODO: implement name
  String get name => 'service';

  Future<bool> run() {
    print('################');
    print('Genereate service here');
    print('################');
  }
  
}