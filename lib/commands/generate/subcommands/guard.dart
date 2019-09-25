import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:wholesome_cli/commands/generate/subcommands/files/guard.dart' as GUARD_FILE;

class GenerateGuard extends Command {

  String fileName;
  String filesPath;
  String baseName;
  String SUFIX = 'Guard';
  String DEFAULT_FOLDER = 'guards';
  
  //-- Singleton
  GenerateGuard() {
    // Add parser options or flag here
  }

  set setfileName (String _name) {
    this.fileName = ReCase(_name).paramCase;
    this.baseName = ReCase(_name).pascalCase;
  }

  @override
  String get description => 'Create guard files and boilerplate code.';

  @override
  String get name => 'guard';

   void run() {
    this.resetState();
    this.getProjectName().then((success) {
      if (success) {
        this.getPathsAndNames();
        print('Generating '+ this.baseName + this.SUFIX);
        this.createCode();
      }
    });

  }

  /**
   * Check if command is valid and get project name
   */
  Future<bool> getProjectName() async {

    bool isFlutterProject = false;
    String projectName;
    
    return await File(p.join(p.current,'pubspec.yaml')).readAsLines().then((lines){
      for (String line in lines) {
        if(line.contains('name:')) {
          projectName = line.split(':')[1].trim();
        }
        
        if (line.contains('flutter')) {
          isFlutterProject = true;
        }

        if (projectName != null && isFlutterProject) {
          break;
        }
      }

      if (projectName == null) {
        throw('no-project-name');
      } else if(!isFlutterProject) {
        throw('no-flutter');
      } else {
        return true;
      }

    }).catchError((e) {
      if (e == 'no-project-name') {
        print('ERROR: Project name not found in pubspec.yaml.');
      } else if (e == 'no-flutter') {
        print('ERROR: This is not a Flutter project, please create a new one with \'wsm new\'.');
      } else {
        print('ERROR: No pubspec.yaml file found.' + e.toString());
      }
      print('NOTICE: To run this command you need to on the root directory of a Flutter project.');
      return false;
    });
  }
  
  /**
   * Get paths and names needed
   */
  void getPathsAndNames() {
    
    List<String> splitArgument = argResults.rest[0].split('/');    
    int dotIdx = splitArgument.indexOf('.');

    if (dotIdx >= 0) {
      splitArgument.removeAt(dotIdx);

      this.filesPath = p.join(p.current, 'lib', this.DEFAULT_FOLDER);

      for (String arg in splitArgument) {

        if (splitArgument.indexOf(arg) == splitArgument.length - 1) {
          this.fileName = ReCase(arg).paramCase;
          this.baseName = ReCase(arg).pascalCase;
        }

        this.filesPath = p.join(this.filesPath, ReCase(arg).paramCase);
      }


    } else {
      this.fileName = ReCase(splitArgument[splitArgument.length - 1]).paramCase;
      this.baseName = ReCase(splitArgument[splitArgument.length - 1]).pascalCase;
      this.filesPath = p.join(p.current, 'lib', this.DEFAULT_FOLDER);
    }

  }

  /**
   * Create each file with boilerplate code
   * | class.dart | 
   */
  void createCode() {
    this.createGuard();
  }

  /**
   * Create Guard File
   */
  void createGuard() {
    File(p.join(this.filesPath, this.fileName +'.dart')).create(recursive: true).then((File file) {
      file.writeAsString(GUARD_FILE.content(this.baseName, this.SUFIX)).then((file) {
        print('- Guard created successfuly ✔');
      });
    });
  }

  /**
   * Reset command to initial state. 
   */
  void resetState() {
    this.fileName = null;
    this.filesPath = null;
    this.baseName = null;
  }
  
}