import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/common/widgets/loader.dart';
import 'package:whatapp_clone/common/widgets/reuse_appbar.dart';
import 'package:whatapp_clone/features/contact/controllers/contact_controller.dart';
import 'package:whatapp_clone/features/contact/widgets/contact_card.dart';
import 'package:whatapp_clone/features/contact/widgets/custom_list_tile.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/routers/router.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ContactView extends ConsumerWidget {
  const ContactView({Key? key}) : super(key: key);

  // ---- method to navigate to chat view---

  navigateToChatPage(context, UserModel user) {
    Navigator.of(context).pushNamed(Routes.chat, arguments: {'user': user});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const ReuseableAppbar(
        title: 'Select contact',
        isCenterTitle: false,
      ),

      // ---- body of the contact view---

      body: ref.watch(getContactProvider).when(
            data: (contactList) => ListView.builder(
              itemCount: contactList[1].length + contactList[0].length,
              itemBuilder: (context, idx) {
                late UserModel firebaseContact;
                late UserModel phoneContact;
                // debugPrint('idx $idx constacts ${contactList[0].length}');
                if (idx < contactList[0].length) {
                  firebaseContact = contactList[0][idx];
                } else {
                  phoneContact = contactList[1][idx - contactList[0].length];
                }

                return idx < contactList[0].length
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ---- Grouping the contact by first letter ----
                          const CustomListTile(
                            leading: Icons.group,
                            text: 'New group',
                          ),
                          const CustomListTile(
                            leading: Icons.contacts,
                            text: 'New contact',
                            trailing: Icons.qr_code,
                          ),
                          if (idx == 0)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'Contacts on whatApp',
                                style: TextStyle(
                                    color: context.theme.greyColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ContactCard(
                            idx: idx,
                            contact: firebaseContact,
                            isPhoneContact: false,
                            onTap: () =>
                                navigateToChatPage(context, firebaseContact),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (idx == contactList[0].length)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text(
                                'Contacts on whatApp',
                                style: TextStyle(
                                    color: context.theme.greyColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ContactCard(
                            idx: idx,
                            contact: phoneContact,
                            isPhoneContact: true,
                          ),
                        ],
                      );
              },
            ),
            error: (err, trac) {
              showAlertDialog(context: context, content: err.toString());
              return null;
            },
            loading: () => const Loader(),
          ),
    );
  }
}
