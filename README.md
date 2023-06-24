# bank_app

# bank_app

Bank App
This is a Flutter application for a simple bank app that allows users to view their account information, send money to other users, update their account details, and view their transaction history.

Features
User authentication: Users can log in using their email and password.

Home page: Displays the user's account balance, name, and a carousel of bank cards associated with the user's account.

Send Money: Allows users to transfer money to other users by entering the recipient's account Number and the amount.

Update Account: Users can update their account details, including their name, email, password and phone Number.

Delete Account: Users can delete their account after confirming their decision.

Transaction History: Shows a list of the user's transactions, including the sender, description, and amount.

Getting Started
To run the app locally, follow these steps:

1.Make sure you have Flutter and Dart installed on your machine.

2.Clone this repository to your local machine.

3.Open the project in your preferred IDE or code editor.

4.Run the following command in the terminal to install the required dependencies:
flutter pub get

5.Connect a device or start an emulator.

6.Run the app using the following command:

flutter run


Project Structure
The project follows a standard Flutter project structure. Here's an overview of the important files and directories:

lib/screens: Contains the different screens of the app, such as the home screen, send money screen,create account screen, update account screen, and login screen.
lib/utilities: Contains utility classes and models used throughout the app, including the Card model, Transaction model, color constants and dimension constants.
lib/widgets: Contains reusable widgets used in the app, such as BigText and SmallText.
lib/main.dart: The entry point of the app where the HomePage widget is rendered.
Dependencies
The app utilizes the following dependencies:

flutter/material.dart: The Flutter material library for building the app's UI components.
dots_indicator: A package for displaying dots to indicate the current position in the carousel.
email_validator: A package to validate email
Other Flutter and Dart dependencies required for building Flutter apps.
Please make sure to review the pubspec.yaml file for the complete list of dependencies and their versions.


Lastly, note that more features and functionalities will be added.

Contributing
Contributions to this project are welcome. If you find any issues or want to add new features, feel free to create a pull request.
