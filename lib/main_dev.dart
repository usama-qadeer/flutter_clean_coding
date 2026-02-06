import 'package:folder_stuture/main_exports.dart';

/// The entry point for the application when it is run in development
/// environment. It sets the environment to development and then
/// calls [runMainApp] to start the app.
void main() {
  AppConfig.environment = Environment.dev;
  runMainApp();
}
