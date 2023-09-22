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

class _HomeViewState extends ConsumerState<HomeView> {
  late Timer time;

  updateUserPresence() async {
    final authController = ref.read(authControllerProvider);

    authController.updateUserPresence();
  }

  @override
  void initState() {
    updateUserPresence();
    time = Timer.periodic(const Duration(minutes: 1), (timer) {
      updateUserPresence();
    });
    super.initState();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
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
