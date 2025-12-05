// Dependency injection for HomeScreen feature
import '../presentation/controllers/home_controller.dart';

// Dependency Injection setup
// This file helps organize the dependency injection for the HomeScreen feature

class HomeInjection {
  // Controller
  static HomeController get homeController => HomeController();
}
