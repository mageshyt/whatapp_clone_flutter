import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/features/chat/widgets/IconWithText.dart';
import 'package:whatapp_clone/features/chat/widgets/lastSeenMessage.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ProfileView extends StatelessWidget {
  final UserModel user;

  const ProfileView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: SilverPersistentDelegate(user),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(children: [
              Container(
                color: Theme.of(context).backgroundColor,
                child: Column(
                  // ---- name----
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 5),
                    // ---- phpne number----
                    Text(
                      user.phoneNumber,
                      style: TextStyle(
                        color: context.theme.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // --- status----
                    Text(
                      'last seen ${lastSeenMessage(user.lastSeen)}',
                      style: TextStyle(
                          color: context.theme.greyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),

                    // ---- media, docs, links, voice calls, video calls, groups, payments, settings----

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconWithText(
                          icon: Icons.call,
                          text: 'Call',
                        ),
                        IconWithText(
                          icon: Icons.videocam,
                          text: 'Video call',
                        ),
                        IconWithText(
                          icon: Icons.search,
                          text: 'search',
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 300),
              const SizedBox(height: 300),
              const SizedBox(height: 300),
              const SizedBox(height: 300),
              const SizedBox(height: 300),
              const SizedBox(height: 300),
              const SizedBox(height: 300),
              const SizedBox(height: 300),
            ]),
          )
        ],
      ),
    );
  }
}

class SilverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final UserModel user;
  final double maxHeaderHeigh = 180;
  final double minHeaderHeigh = kToolbarHeight + 55;
  final double maxImageSize = 130;
  final double minImageSize = 40;

  SilverPersistentDelegate(this.user);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final size = MediaQuery.of(context).size;
    final percent = shrinkOffset / (maxHeaderHeigh - 35);
    final percent2 = shrinkOffset / (maxHeaderHeigh);
    final currentImageSize = (maxImageSize * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final currentImagePosition = ((size.width / 2 - 65) * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Container(
        color: Theme.of(context)
            .appBarTheme
            .backgroundColor!
            .withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
        child: Stack(
          children: [
            // ---- back button and more button---
            Positioned(
                left: 0,
                top: MediaQuery.of(context).viewPadding.top + 5,
                child: CustomIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context))),
            Positioned(
              right: 0,
              top: MediaQuery.of(context).viewPadding.top + 5,
              child: CustomIconButton(icon: Icons.more_vert, onPressed: () {}),
            ),

            // ---- user profile image---

            Positioned(
              left: currentImagePosition,
              top: MediaQuery.of(context).viewPadding.top + 5,
              bottom: 5,
              child: Hero(
                tag: 'profile',
                child: Container(
                  width: currentImageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        user.profilePic,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // --name--

            Positioned(
              left: currentImagePosition + 25,
              top: MediaQuery.of(context).viewPadding.top + 20,
              bottom: 5,
              child: Opacity(
                opacity: percent2 * 2 < 1 ? 0 : 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    user.name,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderHeigh;

  @override
  double get minExtent => minHeaderHeigh;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
