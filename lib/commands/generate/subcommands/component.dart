import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:wholesome_cli/commands/generate/subcommands/files/view.dart' as view_file;
import 'package:wholesome_cli/commands/generate/subcommands/files/events.dart' as events_file;
import 'package:wholesome_cli/commands/generate/subcommands/files/state.dart' as state_file;
import 'package:wholesome_cli/commands/generate/subcommands/files/bloc.dart' as bloc_file;

class GenerateComponent extends Command {

  String projectName;
  String fileName;
  String filesPath;
  String baseName;
  String SUFFIX = 'Component';
  String DEFAULT_FOLDER = 'components';
  bool isStateles = false;

  //-- Singleton
  GenerateComponent() {
    argParser.addFlag('stateless', abbr: 's', defaultsTo: false, negatable: false, callback: (value) {
      this.isStateles = value;
    });
  }

  set setfileName (String _name) {
    this.fileName = ReCase(_name).paramCase;
    this.baseName = ReCase(_name).pascalCase;
  }

  @override
  String get description => 'Create component files and boilerplate code.';

  @override
  String get name => 'component';

  void run() {
    this.resetState();

    this.getProjectName().then((success) {
      if (success) {
        this.getPathsAndNames();
        print('Generating '+ this.baseName + this.SUFFIX);
        this.createCode();

      }
    });

  }

  /**
   * Check if command is valid and get project name
   */
  Future<bool> getProjectName() async {

    bool isFlutterProject = false;
    
    return await File(p.join(p.current,'pubspec.yaml')).readAsLines().then((lines){
      for (String line in lines) {
        if(line.contains('name:') && this.projectName == null) {
          this.projectName = line.split(':')[1].trim();
        }
        
        if (line.contains('flutter')) {
          isFlutterProject = true;
        }

        if (this.projectName != null && isFlutterProject) {
          break;
        }
      }

      if (this.projectName == null) {
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
      this.filesPath = p.join(p.current, 'lib', this.DEFAULT_FOLDER, this.fileName);
    }

  }

  /**
   * GetFolderLevels
   */
  String getFolderLevels() {
    List<String> splitPath = p.split(this.filesPath);
    List<String> levelsFromPages = [];
    String folderFile = '';
    

    for (int i = splitPath.length - 1; i > 0; --i) {
    
      if (splitPath[i] == this.DEFAULT_FOLDER) {
        break;
      }

      levelsFromPages.add(splitPath[i]);
    }
      
    if (levelsFromPages.length > 1){
      for (int i = levelsFromPages.length - 1; i > 0; --i) {
        if (i > 1) {
          folderFile += levelsFromPages[i] + '/';
        } else {
          folderFile += levelsFromPages[i];
        }
      }
    } else {
      folderFile = null;
    }

    return folderFile;
  }

  /**
   * Create each file with boilerplate code
   * | page.view.dart | page.events.dart | page.state.dart | page.bloc.dart |
   */
  void createCode() {

    this.createView();
    if (!this.isStateles) {
      this.createEvents();
      this.createState();
      this.createBloc();
    }

  }

  /**
   * Create View File
   */
  void createView() {
    File(p.join(this.filesPath, this.fileName +'.view.dart')).create(recursive: true).then((File file) {
      file.writeAsString(view_file.content(this.baseName, this.SUFFIX, this.projectName, true, this.fileName, this.isStateles)).then((file) {
        print('- View created successfuly ✔');
      });
    });
  }

  /**
   * Create Events File
   */
  void createEvents() {
    File(p.join(this.filesPath, this.fileName +'.events.dart')).create(recursive: true).then((File file) {
      file.writeAsString(events_file.content(this.baseName, this.SUFFIX)).then((file) {
        print('- Events created successfuly ✔');
      });
    });
  }

  /**
   * Create State File
   */
  void createState() {
    File(p.join(this.filesPath, this.fileName +'.state.dart')).create(recursive: true).then((File file) {
      file.writeAsString(state_file.content(this.baseName, this.SUFFIX)).then((file) {
        print('- State created successfuly ✔');
      });
    });
  }

  /**
   * Create BLoC File
   */
  void createBloc() {
    String folderFile = this.getFolderLevels();

    File(p.join(this.filesPath, this.fileName +'.bloc.dart')).create(recursive: true).then((File file) {
      file.writeAsString(bloc_file.content(this.baseName, this.SUFFIX, this.fileName, this.projectName, this.DEFAULT_FOLDER, fileFolder: folderFile)).then((file) {
        print('- BLoC created successfuly ✔');
      });
    });
  }

  /**
   * Reset command to initial state. 
   */
  void resetState() {
    this.projectName = null;
    this.fileName = null;
    this.filesPath = null;
    this.baseName = null;
  }
  
}
