import 'package:flutter/material.dart';
import 'package:whatapp_clone/features/auth/pages/login_view.dart';
import 'package:whatapp_clone/features/auth/pages/opt_view.dart';
import 'package:whatapp_clone/features/auth/pages/user_information_view.dart';
import 'package:whatapp_clone/features/chat/view/FullScreenImageScreen.dart';
import 'package:whatapp_clone/features/chat/view/chat_view.dart';
import 'package:whatapp_clone/features/chat/view/profile_view.dart';
import 'package:whatapp_clone/features/contact/pages/contact_view.dart';
import 'package:whatapp_clone/features/home/view/home_view.dart';
import 'package:whatapp_clone/features/welcome/view/welcome_screen.dart';

class Routes {
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String verification = 'verification';
  static const String userInformation = 'userInformation';
  static const String home = 'home';
  static const String contact = 'contact';
  static const String chat = 'chat';
  static const String profile = 'chat-profile';
  static const String profilePic = 'chat-profile-pic';

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

      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());

      case contact:
        return MaterialPageRoute(builder: (context) => const ContactView());
      case chat:
        final Map args = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => ChatView(
                  user: args['user'],
                ));
      case profile:
        final Map args = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => ProfileView(
                  user: args['user'],
                ));
      case profilePic:
        final Map args = settings.arguments as Map;

        return MaterialPageRoute(
            builder: (context) => FullScreenImageScreen(
                  imageUrl: args['imageUrl'],
                  title: args['title'],
                ));
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
