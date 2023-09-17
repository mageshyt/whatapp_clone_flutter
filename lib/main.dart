import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/common/widgets/loader.dart';
import 'package:whatapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatapp_clone/features/auth/pages/user_information_view.dart';
import 'package:whatapp_clone/features/home/view/home_view.dart';
import 'package:whatapp_clone/features/welcome/view/welcome_screen.dart';
import 'package:whatapp_clone/firebase_options.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/dark_theme.dart';
import 'package:whatapp_clone/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      title: 'Whatsapp me',
      home: ref.watch(userAuthProvider).when(
          data: (user) {
            debugPrint(user!.uid);
            return user.uid == null ? const Welcome_screen() : const HomeView();
          },
          error: (err, trace) {
            return showAlertDialog(context: context, content: err.toString());
          },
          loading: () => const Loader()),
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
