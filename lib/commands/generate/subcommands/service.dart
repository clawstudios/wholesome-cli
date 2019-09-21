import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:wholesome_cli/commands/generate/subcommands/files/service.dart' as SERVICE_FILE;

class GenerateService extends Command {

  String fileName;
  String filesPath;
  String baseName;
  String SUFIX = 'Service';
  String DEFAULT_FOLDER = 'services';

  //-- Singleton
  GenerateService._privateConstructor() {
    // Add parser options or flag here
  }

  static final GenerateService instance = GenerateService._privateConstructor();

  @override
  String get description => 'Create service files and boilerplate code.';

  @override
  String get name => 'service';

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
        print('ERROR: No pubspec.yaml file found.' + e);
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
      this.filesPath = p.join(p.current, 'lib', this.DEFAULT_FOLDER, this.fileName);
    }

  }

  /**
   * Create each file with boilerplate code
   * | class.service.dart | 
   */
  void createCode() {
    this.createService();
  }

  /**
   * Create View File
   */
  void createService() {
    File(p.join(this.filesPath, this.fileName +'.view.dart')).create(recursive: true).then((File file) {
      file.writeAsString(SERVICE_FILE.content(this.baseName, this.SUFIX)).then((file) {
        print('- Service created successfuly ✔');
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