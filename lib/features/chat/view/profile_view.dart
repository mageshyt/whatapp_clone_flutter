import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/chat/widgets/custom_list_title_chat.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/chat_user_info.widget.dart';

class ProfileView extends StatelessWidget {
  final UserModel user;

  const ProfileView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.profilePageBg,
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
                    ChatUserInfoWidget(user: user),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ---- Bio----
              ListTile(
                contentPadding: const EdgeInsets.only(left: 30),
                title: const Text('Hey there! I am using WhatsApp.'),
                subtitle: Text(
                  "27th may ",
                  style: TextStyle(
                    color: context.theme.greyColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // -------- Mute notification----
              ChatCustomListTitle(
                title: 'Mute notification',
                leading: Icons.notifications,
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              // ---- custom notification----
              ChatCustomListTitle(
                title: 'Custom notification',
                leading: Icons.music_note,
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
              // ----- Media visibility----
              ChatCustomListTitle(
                title: 'Media visibility',
                leading: Icons.photo,
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),

              const SizedBox(height: 20),
              // ---- Encryption----
              const ChatCustomListTitle(
                title: 'Encryption',
                leading: Icons.lock,
                subTitle:
                    'Messages and calls are end-to-end encrypted. Tap to verify.',
              ),

              // ---- disappearing messages----
              const ChatCustomListTitle(
                title: 'Disappearing messages',
                subTitle: 'Off',
                leading: Icons.timer,
              ),

              ListTile(
                leading: CustomIconButton(
                  onPressed: () {},
                  icon: Icons.group,
                  backgroundColor: ThemeColors.greenDark,
                  iconsColor: Colors.white,
                ),
                title: Text('Create group with ${user.name}'),
              ),
              const SizedBox(height: 20),

              ListTile(
                contentPadding: const EdgeInsets.only(left: 25, right: 10),
                leading: const Icon(
                  Icons.block,
                  color: ThemeColors.dangerLight,
                ),
                title: Text(
                  'Block ${user.name}',
                  style: const TextStyle(
                    color: ThemeColors.dangerLight,
                  ),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 25, right: 10),
                leading: const Icon(
                  Icons.thumb_down,
                  color: ThemeColors.dangerLight,
                ),
                title: Text(
                  'Report ${user.name}',
                  style: const TextStyle(
                    color: ThemeColors.dangerLight,
                  ),
                ),
              ),

              const SizedBox(height: 50),
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

  // method to show the image in full screen

  showImageInFullScreen(BuildContext context) {
    Navigator.pushNamed(context, Routes.profilePic,
        arguments: {'imageUrl': user.profilePic, 'title': user.name});
  }

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
              child: GestureDetector(
                onTap: () => showImageInFullScreen(context),
                child: Hero(
                  tag: 'profile',
                  child: Container(
                    width: currentImageSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(user.profilePic),
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
