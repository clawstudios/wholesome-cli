import 'dart:io';
import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:wholesome_cli/commands/generate/generate.dart';
import 'package:wholesome_cli/commands/new/new.dart';


void main(List<String> arguments) {
  exitCode = 0; //presume success

  final CommandRunner commandRunner = CommandRunner('wsm', 'Code Generator for Flutter Projects.')
    ..addCommand(Creator.instance)
    ..addCommand(Generator.instance);

  commandRunner.run(arguments).catchError((error) {
    if (error is! UsageException) throw error;
    print(error);
    exit(64); // Exit code 64 indicates a usage error.
  });
}
