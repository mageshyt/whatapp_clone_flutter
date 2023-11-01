import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatapp_clone/features/home/view/call_home_view.dart';
import 'package:whatapp_clone/features/home/view/chat_home_view.dart';
import 'package:whatapp_clone/features/home/view/status_home_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView>
    with WidgetsBindingObserver {
  updateUserPresence(bool isOnline) async {
    final authController = ref.read(authControllerProvider);

    authController.updateUserPresence(isOnline);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('resumed');
        updateUserPresence(true);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        debugPrint('paused');
        updateUserPresence(false);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 1,
          actions: [
            CustomIconButton(
                icon: Icons.search, onPressed: () {}, iconSize: 25),
            CustomIconButton(
                icon: Icons.more_vert, onPressed: () {}, iconSize: 25)
          ],
          bottom: const TabBar(
            splashFactory: NoSplash.splashFactory,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'CHATS'),
              Tab(text: 'STATUS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [ChatHomeView(), StatusHomeView(), CallHomeView()],
        ),
      ),
    );
  }
}
