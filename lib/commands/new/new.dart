import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:args/command_runner.dart';
import 'package:wholesome_cli/commands/generate/subcommands/component.dart';
import 'package:wholesome_cli/commands/generate/subcommands/guard.dart';
import 'package:wholesome_cli/commands/generate/subcommands/model.dart';
import 'package:wholesome_cli/commands/generate/subcommands/page.dart';
import 'package:wholesome_cli/commands/generate/subcommands/service.dart';
import 'package:wholesome_cli/commands/new/files/assets.dart' as ASSETS_FILE;
import 'package:wholesome_cli/commands/new/files/routes.dart' as ROUTES_FILE;
import 'package:wholesome_cli/commands/new/files/helpers.dart' as HELPERS_FILE;
import 'package:wholesome_cli/commands/new/files/colors.dart' as COLORS_FILE;
import 'package:wholesome_cli/commands/new/files/main.dart' as MAIN_FILE;

class Creator extends Command {

  String projectName;
  String basePath;

  //-- Singleton
  Creator._privateConstructor() {
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

          this.projectName = argResults.rest[0];
          this.basePath = p.join(p.current, argResults.rest[0]);
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

    String directory = p.join(this.basePath, 'lib', 'common');

    Directory(directory).createSync();
    print('- /lib/common/ ✔');

    // Assets
    File(p.join(directory, 'assets.dart')).writeAsStringSync(ASSETS_FILE.content);
    print('-- /lib/common/assets.dart ✔');

    // Colors
    File(p.join(directory, 'colors.dart')).writeAsStringSync(COLORS_FILE.content);
    print('-- /lib/common/colors.dart ✔');
    
    // Helpers
    File(p.join(directory, 'helpers.dart')).writeAsStringSync(HELPERS_FILE.content);
    print('-- /lib/common/helpers.dart ✔');
    
    // Routes
    File(p.join(directory, 'routes.dart')).writeAsStringSync(ROUTES_FILE.content(this.projectName));
    print('-- /lib/common/routes.dart ✔');
      
  }

  /**
   * Create Components Folder with the default config files.
   */
  void createComponents() {
    String path = p.join(this.basePath, 'lib', 'components');
    Directory(path).create().then((Directory directoy) {
      GenerateComponent componentGen = GenerateComponent();
      componentGen.filesPath = p.join(path, 'example');
      componentGen.setfileName = 'example';
      componentGen.projectName = this.projectName;
      componentGen.createCode();
      print('- /lib/components/ ✔');
    });
  }

  /**
   * Create Guards Folder with the default config files.
   */
  void createGuards() {
    String path = p.join(this.basePath, 'lib', 'guards');
    Directory(path).create().then((Directory directory) {
      GenerateGuard guardGen = GenerateGuard();
      guardGen.filesPath = path;
      guardGen.setfileName = 'example';
      guardGen.createCode();
      print('- /lib/guards/ ✔');
    });
  }

  /**
   * Create Models Folder with the default config files.
   */
  void createModels() {

    String path = p.join(this.basePath, 'lib', 'models');
    Directory(path).create().then((Directory directory) {
      GenerateModel modelGen = GenerateModel();
      modelGen.filesPath = path;
      modelGen.setfileName = 'example';
      modelGen.createCode();
      print('- /lib/models/ ✔');
    });
    
  }

  /**
   * Create Pages Folder with the default config files.
   */
  void createPages() {
    String path = p.join(this.basePath, 'lib', 'pages');
    Directory(path).create().then((Directory directory) {
      GeneratePage pageGen = GeneratePage();
      pageGen.filesPath = p.join(path, 'home');
      pageGen.setfileName = 'home';
      pageGen.projectName = this.projectName;
      pageGen.createCode();
      print('- /lib/pages/ ✔');
    });
  }

  /**
   * Create Services Folder with the default config files.
   */
  void createServices() {
    String path = p.join(this.basePath, 'lib', 'services');
    Directory(path).create().then((Directory directory) {
      GenerateService modelGen = GenerateService();
      modelGen.filesPath = path;
      modelGen.setfileName = 'example';
      modelGen.createCode();
      print('- /lib/services/ ✔');
    });
  }

  /**
   * Create Assets Folder with the default config files.
   */
  void createAssets() {
    Directory(p.join(this.basePath, 'assets')).create().then((Directory directory) {
      print('- /assets/ ✔');

      // Donwload svg logo from somewhere (s3 ??)

    });
  }

  /**
   * Rewrite the Main.dart file to use Routes.
   */
  void rewriteMain() {
    
    File(p.join(this.basePath, 'lib','main.dart')).writeAsString(MAIN_FILE.content(this.projectName)).then((File file) {
      print('-- /lib/main.dart ✔');
    });

  }

}