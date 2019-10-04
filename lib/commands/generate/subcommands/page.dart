import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/command_runner.dart';
import 'package:recase/recase.dart';
import 'package:wholesome_cli/commands/generate/subcommands/files/view.dart' as VIEW_FILE;
import 'package:wholesome_cli/commands/generate/subcommands/files/events.dart' as EVENTS_FILE;
import 'package:wholesome_cli/commands/generate/subcommands/files/state.dart' as STATE_FILE;
import 'package:wholesome_cli/commands/generate/subcommands/files/bloc.dart' as BLOC_FILE;

class GeneratePage extends Command {

  bool isStatefuleWidget = false;
  String projectName;
  String fileName;
  String filesPath;
  String baseName;
  String SUFIX = 'Page';
  String DEFAULT_FOLDER = 'pages';

  //-- Singleton
  GeneratePage() {
    // Add parser options or flag here
    argParser.addFlag('stateful', abbr: 's');
  }

  set setfileName (String _name) {
    this.fileName = ReCase(_name).paramCase;
    this.baseName = ReCase(_name).pascalCase;
  }

  @override
  String get description => 'Create page files and boilerplate code.';

  @override
  String get name => 'page';

  void run() {
    this.resetState();

    this.getProjectName().then((success) {
      if (success) {
        if (argResults.wasParsed('stateful')) {
          this.isStatefuleWidget = true;
        }

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
  void createCode({ bool isSplash = false }) {

    if (isSplash) {
      this.createSplashView();
      this.createSplashEvents();
      this.createSplashBloc();
    } else {
      this.createView();
      this.createEvents();
      this.createBloc();
    }
    
    this.createState();

  }

  /**
   * Create View File
   */
  void createView() {
    File(p.join(this.filesPath, this.fileName +'.view.dart')).create(recursive: true).then((File file) {
      file.writeAsString(VIEW_FILE.content(this.baseName, this.SUFIX, this.projectName, false, this.fileName, false)).then((file) {
        print('- View created successfuly ✔');
      });
    });
  }

  /**
   * Create Splash View File
   */
  void createSplashView() {
    File(p.join(this.filesPath, this.fileName +'.view.dart')).create(recursive: true).then((File file) {
      file.writeAsString(VIEW_FILE.splashContent(this.baseName, this.SUFIX, this.projectName, this.fileName)).then((file) {
        print('- Splash View created successfuly ✔');
      });
    });
  }

  /**
   * Create Events File
   */
  void createEvents() {
    File(p.join(this.filesPath, this.fileName +'.events.dart')).create(recursive: true).then((File file) {
      file.writeAsString(EVENTS_FILE.content(this.baseName, this.SUFIX)).then((file) {
        print('- Events created successfuly ✔');
      });
    });
  }

  /**
   * Create Splash Events File
   */
  void createSplashEvents() {
    File(p.join(this.filesPath, this.fileName +'.events.dart')).create(recursive: true).then((File file) {
      file.writeAsString(EVENTS_FILE.splashContent(this.baseName, this.SUFIX)).then((file) {
        print('- Splash Events created successfuly ✔');
      });
    });
  }

  /**
   * Create State File
   */
  void createState() {
    File(p.join(this.filesPath, this.fileName +'.state.dart')).create(recursive: true).then((File file) {
      file.writeAsString(STATE_FILE.content(this.baseName, this.SUFIX)).then((file) {
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
      file.writeAsString(BLOC_FILE.content(this.baseName, this.SUFIX, this.fileName, this.projectName, this.DEFAULT_FOLDER, fileFolder: folderFile)).then((file) {
        print('- BLoC created successfuly ✔');
      });
    });
  }

  /**
   * Create Splash Bloc File
   */
  void createSplashBloc() {
    String folderFile = this.getFolderLevels();

    File(p.join(this.filesPath, this.fileName +'.bloc.dart')).create(recursive: true).then((File file) {
      file.writeAsString(BLOC_FILE.splashContent(this.baseName, this.SUFIX, this.fileName, this.projectName, this.DEFAULT_FOLDER, fileFolder: folderFile)).then((file) {
        print('- BLoC Splash created successfuly ✔');
      });
    });
  }

  /**
   * Reset command to initial state. 
   */
  void resetState() {
    this.isStatefuleWidget = false;
    this.projectName = null;
    this.fileName = null;
    this.filesPath = null;
    this.baseName = null;
  }
}