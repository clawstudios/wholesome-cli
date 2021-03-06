import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:wholesome_cli/commands/generate/subcommands/component.dart';
import 'package:wholesome_cli/commands/generate/subcommands/guard.dart';
import 'package:wholesome_cli/commands/generate/subcommands/model.dart';
import 'package:wholesome_cli/commands/generate/subcommands/page.dart';
import 'package:wholesome_cli/commands/generate/subcommands/service.dart';

class Generator extends Command {
  //-- Singleton
  Generator._privateConstructor() {
    
    // Add Sub Commands
    addSubcommand(GenerateComponent());
    addSubcommand(GeneratePage());
    addSubcommand(GenerateService());
    addSubcommand(GenerateModel());
    addSubcommand(GenerateGuard());

    // Add parser options or flag here
  }

  static final Generator instance = Generator._privateConstructor();

  @override
  String get description => 'Generate a boilerplate code.';

  @override
  String get name => 'generate';

  // [run] may also return a Future.
  void run() {
 
    

    this.runner.runCommand(argResults).catchError((error) {
      if (error is! UsageException) throw error;
      print(error);
      exit(64); // Exit code 64 indicates a usage error.
    });

  }


}