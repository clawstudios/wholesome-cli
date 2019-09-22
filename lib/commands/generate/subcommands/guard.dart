import 'package:args/command_runner.dart';

class GenerateGuard extends Command {

  //-- Singleton
  GenerateGuard._privateConstructor() {
    // Add parser options or flag here
  }

  static final GenerateGuard instance = GenerateGuard._privateConstructor();

  @override
  String get description => 'Create guard files and boilerplate code.';

  @override
  String get name => 'guard';

  void run() {
    print('################');
    print('Genereate guard here');
    print('################');
  }
  
}