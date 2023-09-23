import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/common/widgets/loader.dart';
import 'package:whatapp_clone/features/contact/controllers/contact_controller.dart';
import 'package:whatapp_clone/features/contact/widgets/contact_card.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ChatHomeView extends ConsumerWidget {
  const ChatHomeView({Key? key}) : super(key: key);

  // ---- method to navigate to contact view---
  navigateToContactPage(context) {
    Navigator.pushNamed(
      context,
      Routes.contact,
    );
  }

  // ---- method to navigate to chat view---

  navigateToChatPage(context, UserModel user) {
    Navigator.of(context).pushNamed(Routes.chat, arguments: {'user': user});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: ref.watch(getFirebaseContactProvider).when(
              data: (contactList) => ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  return ContactCard( 
                      onTap: () =>
                          navigateToChatPage(context, contactList[index]),
                      idx: index,
                      contact: contactList[index],
                      isPhoneContact: false);
                },
              ),
              error: (err, trac) {
                showAlertDialog(context: context, content: err.toString());
                return null;
              },
              loading: () => const Loader(),
            ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToContactPage(context),
          child: const Icon(Icons.chat),
        ));
  }
}
