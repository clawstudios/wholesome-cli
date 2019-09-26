![A Command Line Tool that facilitates code generation for Flutter projects.](https://www.clawstudios.com/assets/wholesome/icon.png)

Wholesome is a Command Line Tool that aims to facilitate code generation for [Flutter](https://flutter.dev/) projects, proposing a default architecture similar to an MVC architecture but using BLoC pattern.

## Requeriments
This tool is executed using [pub](https://pub.dev/) and generate code for [Flutter](https://flutter.dev/) projects this means that you will need:
 - [Dart SDK](https://dart.dev/get-dart)
 - [Flutter](https://flutter.dev/docs/get-started/install)

## Installation
Since the tool is still on development and is an early version for testing, you must install it from the git repository using local source or online source.

### Network
You can install the tool with this repo link running the following line:

    pub global activate --source git https://github.com/clawstudios/wholesome-cli.git

### Local
If you clone the reopository, you can install the tool with the following line

    pub global activate --source path <path>

### Add executable folder to $PATH
To execute Wholesome from your command line, you will have to add the [pub](https://pub.dev/) cache folder to the PATH.
Check out the [Running Script](https://dart.dev/tools/pub/cmd/pub-global#running-a-script) section in the [pub-global](https://dart.dev/tools/pub/cmd/pub-global) dart documentation to add the path correctly to you Operating System.

## Before Starting

The whole tool is based on the following folder structure.
*You can read more about each folder in the section of each subcommand of the generator.*

    / myproject
      |- .idea
      |- android
      |- assets
      |- ios
      |- lib
        |- common
        |- components
	  |- mycomponent
	    |- mycomponent.bloc.dart
	    |- mycomponent.events.dart
	    |- mycomponent.state.dart
	    |- mycomponent.view.dart
        |- guards
        |- models
        |- pages
	  |- mypage
	    |- mypage.bloc.dart
	    |- mypage.events.dart
	    |- mypage.state.dart
	    |- mypage.view.dart
        |- services
      |- test



## Commands
Every Wholesome command will need to be executed by the **wsm** binary. At the moment, you will be able to run the following commands and subcommands:
 - new
 - generate
	 - component
	 - guard
	 - model
	 - page
	 - service

## New

The **new** command will generate a new Flutter project with a specific name, and will generate the previously detailed folder structurewith some boilerplate code.

    wsm new myproject
    
*This command will run 'flutter new' and then will generate the structure and files.*

This command will also generate the following files inside the **common** folder:
 - assets.dart
 - colors.dart
 - helpers.dart
 - routes.dart
 - styles.dart

### Assets, Colors and Styles
In these files you can have all your constants with asset paths, custom colors, or custom styles that you need to reuse on every part of the app.

You can use the constants import the files in the following way:

    import  'package:myproject/common/assets.dart'  as ASSETS;
    import  'package:myproject/common/colors.dart'  as COLORS;
    import  'package:myproject/common/styles.dart'  as STYLES;

### Helpers
This is a file to put all the helper functions that you will use to develop your app.

You need to import it like this:

    import  'package:myproject/common/helpers.dart'  as HELPERS;
 
And you will find two methods for printing to console.

    HELPERS.printError('This is an error message.');
    HELPERS.printWarn('This is a warning message.');

### Routes
In this file you will find a ROUTES Map in where you can add routes and associate them with the generated Page.

For more information about routing, please check [Flutter Routing Docs](https://flutter.dev/docs/development/ui/navigation) .

## Generate

This command generate boilerplate code, you must pass **one subcommand as a parameter** and you must **execute this command under a Flutter Project** 

    wsm generate <subcommand>

### Component

A component is a reutilizable implementation of code that could have one or more files.

#### Stateful Component
For components with state management, Wholesome will generate a set of files inside a folder with the name of the component (as you can see in the Before Starting section, inside the 'components' folder)

    wsm generate component <name>

**Generated Files:** 

**name.bloc.dart**
This file will contain all the Business Logic and also will manage the State of the component through events.

**name.events.dart**
Contains an abstract class ready to be extended by custom events that will be used to comunicate between BLoC and View.

**name.state.dart**
Contains a class with the State data of the component and will be modified only by the BLoC.

**name.view.dart:**
Is a StatefulWidget with a BLoC instance in it and a dispose implementation that includes the BLoC to shutdown the BLoC controllers when disposing the view.

#### Stateless Component (NOT IMPLEMENTED YET)
For components without state management, Wholesome will generate only a view.

    wsm generate component <name> -s
    # or
    wsm generate component <name> -stateless

### Guard

Guard classes have methods to manage the access to one or more views, we think that a singleton with a  **canActivate** method that returns a boolean is a start, and can be extended as needed.
*We know we need to implement a more wayto handle a view lifecycle *
*These files are created under 'guards' folder as shown in the Before Starting section.*

    wsm generate guard <name>

### Model

Models are classes that represents different data models handled inside an app such as user data to show in a profile view.
*Models are located inside 'models' folder. (check the previously detailed folder structure).*

    wsm generate model <name>

### Page

Pages are StatefulWidgets with the same structure as components, but they represent a whole view and can be accessed navigating to their specific route. In pages is where you will instantiate components and handle page state and model mutations on the BLoC.
*Pages are located inside 'pages' folder. (check the previously detailed folder structure).*

    wsm generate page <name>

See Routes Section to know how to add a route to your page.

### Service

Services are singletons that exposes methods to interact with the external resources such as APIs or Databases data models handled inside an app such as user data to show in a profile view.
*Services are located inside 'services' folder. (check the previously detailed folder structure).*

    wsm generate service <name>

## Credits
This tool is a development in progress by [Claw Studios](https://www.clawstudios.com/). If you want to contribute, help or contact here is our email info@clawstudios.com use a subject with the name of the tool.

