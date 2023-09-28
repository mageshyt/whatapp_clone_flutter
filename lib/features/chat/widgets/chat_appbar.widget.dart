import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/features/auth/repository/auth_repository.dart';
import 'package:whatapp_clone/features/chat/widgets/lastSeenMessage.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChatAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final UserModel user;

  const ChatAppBar({
    super.key,
    required this.user,
  });

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
  }

  // ---- method to navigate to profile view---

  navigateToProfilePage(context, UserModel user) {
    Navigator.of(context).pushNamed(Routes.profile, arguments: {'user': user});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      title: InkWell(
        onTap: () => navigateToProfilePage(context, user),
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
                  // debugPrint('singleUserModel ${singleUserModel.toMap()}}');

                  return Text(
                    singleUserModel.isOnline
                        ? 'online'
                        : 'last seen ${lastSeenMessage(singleUserModel.lastSeen)}',
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
            const Icon(
              Icons.arrow_back,
            ),
            Hero(
              tag: 'profile',
              child: Container(
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(user.profilePic),
                  ),
                ),
              ),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
