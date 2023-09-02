import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/auth/pages/login_view.dart';
import 'package:whatapp_clone/features/auth/pages/opt_view.dart';
import 'package:whatapp_clone/features/auth/pages/user_information_view.dart';
import 'package:whatapp_clone/features/welcome/view/welcome_screen.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInformation = 'userInformation';
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (context) => const Welcome_screen());
      case login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case verification:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (context) => OTPScreen(
                  verificationId: args['verificationId'],
                  phoneNumber: args['phoneNumber'],
                ));

      case userInformation:
        return MaterialPageRoute(
            builder: (context) => const UserInformationView());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Page Route Provided'),
            ),
          ),
        );
    }
  }
}
