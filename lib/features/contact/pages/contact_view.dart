import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/common/widgets/loader.dart';
import 'package:whatapp_clone/common/widgets/reuse_appbar.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/features/contact/controllers/contact_controller.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactView extends ConsumerWidget {
  const ContactView({Key? key}) : super(key: key);

//-- share SMS Link--

  shareSMS(String phone) async {
    log('phone $phone');
    Uri sms = Uri.parse(
        "sms:$phone?body=Let's chat on whatApp! its fast and secure . Download it from https://play.google.com/store/apps/details?id=com.whatsapp");
 
    if (await launchUrl(sms)) {
    } else {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: ReuseableAppbar(
        title: 'Select contact',
        subText: ref.watch(getContactLength).toString() + ' contacts',
        isCenterTitle: false,
        backgroundColor: ThemeColors.greyBackground,
        actions: [
          CustomIconButton(icon: Icons.search, onPressed: () {}),
          CustomIconButton(icon: Icons.more_vert, onPressed: () {})
        ],
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
                          ListTile(
                            contentPadding: const EdgeInsets.only(
                                left: 20, right: 10, top: 0, bottom: 0),
                            dense: true,
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  firebaseContact.profilePic.isNotEmpty
                                      ? NetworkImage(firebaseContact.profilePic,
                                          scale: 1)
                                      : null,
                              backgroundColor:
                                  context.theme.greyColor!.withOpacity(0.3),
                              child: firebaseContact.profilePic.isEmpty
                                  ? const Icon(Icons.person, size: 30)
                                  : const SizedBox(),
                            ),

                            // ---- title of the contact list---

                            title: Text(
                              firebaseContact.name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),

                            subtitle: Text(
                              "Hey there! I am using whatApp",
                              style: TextStyle(
                                  color: context.theme.greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
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
                          ListTile(
                              contentPadding: const EdgeInsets.only(
                                  left: 20, right: 10, top: 10, bottom: 10),
                              dense: true,
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    phoneContact.profilePic.isNotEmpty
                                        ? NetworkImage(phoneContact.profilePic,
                                            scale: 1)
                                        : null,
                                backgroundColor:
                                    context.theme.greyColor!.withOpacity(0.3),
                                child: phoneContact.profilePic.isEmpty
                                    ? const Icon(Icons.person, size: 30)
                                    : const SizedBox(),
                              ),
                              // ---- title of the contact list---
                              title: Text(
                                phoneContact.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                phoneContact.phoneNumber,
                                style: TextStyle(
                                    color: context.theme.greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),

                              // ---- trailing of the contact list---

                              trailing: TextButton(
                                onPressed: () =>
                                    shareSMS(phoneContact.phoneNumber),

                                // ---- style of the trailing button---

                                style: TextButton.styleFrom(
                                    backgroundColor: context.theme.greyColor!
                                        .withOpacity(0.2),
                                    foregroundColor: ThemeColors.greenDark,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                child: const Text(
                                  "Invite",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ))
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
