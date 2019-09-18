import 'package:args/command_runner.dart';

class GeneratePage extends Command {

  //-- Singleton
  GeneratePage._privateConstructor() {
    // Add parser options or flag here
  }

  static final GeneratePage instance = GeneratePage._privateConstructor();

  @override
  // TODO: implement description
  String get description => 'Create page files and boilerplate code.';

  @override
  // TODO: implement name
  String get name => 'page';

  Future<bool> run() {
    print('################');
    print('Genereate page here');
    print('################');
  }
  
}