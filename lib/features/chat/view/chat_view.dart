import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';

class ChatView extends ConsumerWidget {
  final UserModel user;
  const ChatView({Key? key, required this.user}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
  }

  // --- method to get last seen time---
  String lastSeenMessage(lastSeen) {
    DateTime now = DateTime.now();
    Duration differenceDuration = now.difference(
      DateTime.fromMillisecondsSinceEpoch(lastSeen),
    );

    String finalMessage = differenceDuration.inSeconds > 59
        ? differenceDuration.inMinutes > 59
            ? differenceDuration.inHours > 23
                ? "${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day' : 'days'}"
                : "${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour' : 'hours'}"
            : "${differenceDuration.inMinutes} ${differenceDuration.inMinutes == 1 ? 'minute' : 'minutes'}"
        : 'few moments';

    return finalMessage;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- name----
                Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 3),
                // --- status----

                StreamBuilder(
                  stream: ref
                      .watch(authRepositoryProvider)
                      .getUserPresenceStatus(user.uid as String),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState != ConnectionState.active) {
                      return const Text(
                        'connecting',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      );
                    }

                    final singleUserModel = snapshot.data!;
                    // debugPrint('single user model ${singleUserModel['isOnline']}');
                    return Text(
                      singleUserModel.isOnline
                          ? 'online'
                          : '${lastSeenMessage(singleUserModel.lastSeen)}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
        leading: InkWell(
          onTap: () => navigateToContactPage(context),
          borderRadius: BorderRadius.circular(16),
          child: Row(
            children: [
              const Icon(Icons.arrow_back),
              CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
                radius: 16,
              ),
            ],
          ),
        ),
        actions: [
          CustomIconButton(
            icon: Icons.videocam,
            onPressed: () {},
            iconsColor: Colors.white,
          ),
          CustomIconButton(
            icon: Icons.call,
            onPressed: () {},
            iconsColor: Colors.white,
          ),
          CustomIconButton(
            icon: Icons.more_vert,
            onPressed: () {},
            iconsColor: Colors.white,
          ),
        ],
      ),
      body: const Center(
        child: Text('Chat Home View'),
      ),
    );
  }
}
