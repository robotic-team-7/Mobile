# Mobile

# Documentation for the mobile application for Mower project group 7

## Project Outline

- This is an iOS app for a lawnmower project at Jönköping Tekniska Högskola.
- The application is developed in XCode using the Swift programming language and utilizes SwiftUI as a universal interface framework.

## The application architecture

- The application utilizes the Model View software architecture which is a common standard in iOS development. It means that Model classes provide data to be displayed in View classes.

### Build Steps

1. Open project in XCode
2. Let XCode index all files.
3. Compile and run application, by default in a simulator by clicking "Run".

### Using the app

1. When starting the app, the user is prompted to enter authentication details to access the navigation system.
2. In dashboard, the user can do a multitude of things...
   - Access the dashboard by tapping the "Home" icon. This screen is allows for toggling various features of the mower and displays a summary of an active mowing session.
   - Access the map by tapping the "Map" icon. The map shows the current mower position of an active mowing session, its trajectory and detected obstacles.
   - Access the gallery by tapping the "Photo" icon. In the gallery it is possible to view pictures and identified details of detected obstacles.
   - Access the bluetooth remote by tapping the "Gamepad". Use the gamepad to control a mower directly using Bluetooth Low Energy.

## Contributing Guidelines

Want to contribute to this repository? Please follow the following guidelines.

### Missing Features or bugs?

If you want to report a bug or suggest a new feature, please contact Filip or Ruben.

### Creating a pull request

- When you have work that you want to merge, create a pull request from your branch in to the target branch.
- When your pull request is created, ideally notify another group member to review the changes.
- When changes has been reviewed the branch is squashed and merged to the target branch.

### Coding Rules

- **Class files are categorized into different directories, depending on their role as Model or View.**
  Example 1: A class for handling external API communication may be stored in ".../Mobile/Models/ApiInterface.swift"
  Example 2: A class responsible for drawing elements that are viewed on the device screen may be stored in ".../Mobile/Views/MapView.swift"

- **Snake casing is used for class file names**
  Example: An api interface class may be called "ApiInterface"
- **Camel casing is used for objects/variable names.**
  Example: An instance of the class ApiInterface may be named apiInterface.

### Commits

- Please commit your code frequently with relevant description for each associated change.
