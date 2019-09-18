import 'dart:io';
import 'package:args/command_runner.dart';
import 'package:wholesome_cli/commands/new/files/assets.dart' as ASSETS_FILE;
import 'package:wholesome_cli/commands/new/files/routes.dart' as ROUTES_FILE;
import 'package:wholesome_cli/commands/new/files/helpers.dart' as HELPERS_FILE;
import 'package:wholesome_cli/commands/new/files/colors.dart' as COLORS_FILE;
import 'package:wholesome_cli/commands/new/files/main.dart' as MAIN_FILE;

class Creator extends Command {

  String basePath;

  //-- Singleton
  Creator._privateConstructor() {
    // Add parser options or flag here
  }

  static final Creator instance = Creator._privateConstructor();

  @override
  String get description => 'Creates a new Flutter Project with a preconfigured folder structure and and MVC Architecture.';

  @override
  String get name => 'new';

  // [run] may also return a Future.
  void run() {
 
    if (argResults.rest.isEmpty) {
      print('Please provide a name for the project');
    } else {

  
      print('\n');
      print('# Creating New Flutter Project');

      Process.run(Platform.isWindows ? 'flutter.bat' : 'flutter', ['create', argResults.rest[0]]).then((result) {
        if (result.stderr != null) {
          stderr.write(result.stderr);
        }
        
        if (result.stdout != null) {
          stdout.write(result.stdout);

          this.basePath = argResults.rest[0];
          print('\n');
          print('# Creating Architecture');
          this.createCommon();
          this.createComponents();
          this.createGuards();
          this.createModels();
          this.createPages();
          this.createServices();
          this.rewriteMain();
        }

      });


    }

  }

  /**
   * Create Common Folder with the default config files.
   */
  void createCommon() {
    Directory(this.basePath + '/lib/common/').create().then((Directory directory) {
      print('- /lib/common/ ✔');

      // Assets
      File('./' + directory.path + 'assets.dart').writeAsString(ASSETS_FILE.content).then((File file) {
        print('-- /lib/common/assets.dart ✔');
      });

      // Colors
      File('./' + directory.path + 'colors.dart').writeAsString(COLORS_FILE.content).then((File file) {
        print('-- /lib/common/colors.dart ✔');
      });

      // Helpers
      File('./' + directory.path + 'helpers.dart').writeAsString(HELPERS_FILE.content).then((File file) {
        print('-- /lib/common/helpers.dart ✔');
      });

      // Routes
      File('./' + directory.path + 'routes.dart').writeAsString(ROUTES_FILE.content(this.basePath)).then((File file) {
        print('-- /lib/common/routes.dart ✔');
      });

    });
  }

  /**
   * Create Components Folder with the default config files.
   */
  void createComponents() {
    Directory(this.basePath + '/lib/components/').create().then((Directory directory) {
      print('- /lib/components/ ✔');
      
      // call generate component with name 'Example Component';

    });
  }

  /**
   * Create Guards Folder with the default config files.
   */
  void createGuards() {
    Directory(this.basePath + '/lib/guards/').create().then((Directory directory) {
      print('- /lib/guards/ ✔');

      // call generate guard with name 'Example Guard';

    });
  }

  /**
   * Create Models Folder with the default config files.
   */
  void createModels() {
    Directory(this.basePath + '/lib/models/').create().then((Directory directory) {
      print('- /lib/models/ ✔');

      // call generate model with name 'Example Model';

    });
  }

  /**
   * Create Pages Folder with the default config files.
   */
  void createPages() {
    Directory(this.basePath + '/lib/pages/').create().then((Directory directory) {
      print('- /lib/pages/ ✔');

      // call generate page with name 'Example Page';

    });
  }

  /**
   * Create Services Folder with the default config files.
   */
  void createServices() {
    Directory(this.basePath + '/lib/services/').create().then((Directory directory) {
      print('- /lib/services/ ✔');

      // call generate service with name 'Example Service'

    });
  }

  /**
   * Create Assets Folder with the default config files.
   */
  void createAssets() {
    Directory(this.basePath + '/assets/').create().then((Directory directory) {
      print('- /assets/ ✔');

      // call generate default assets

    });
  }

  /**
   * Rewrite the Main.dart file to use Routes.
   */
  void rewriteMain() {
    
    File('./' + this.basePath + '/lib/main.dart').writeAsString(MAIN_FILE.content(this.basePath)).then((File file) {
      print('-- /lib/main.dart ✔');
    });

  }

}