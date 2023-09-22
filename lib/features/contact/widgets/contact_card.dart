import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:whatapp_clone/constants/colors.dart';
import 'package:whatapp_clone/models/user_model.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final int idx;
  final UserModel contact;
  final bool isPhoneContact;
  final VoidCallback? onTap;

  const ContactCard({
    Key? key,
    required this.idx,
    required this.contact,
    this.onTap,
    required this.isPhoneContact,
  }) : super(key: key);

//-- share SMS Link--

  shareSMS(String phone) async {
    log('phone $phone');
    Uri sms = Uri.parse(
        "sms:$phone?body=Let's chat on whatApp! its fast and secure . Download it from https://play.google.com/store/apps/details?id=com.whatsapp");

    if (await launchUrl(sms)) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(
                left: 20,
                right: 10,
                top: isPhoneContact ? 5 : 0,
                bottom: isPhoneContact ? 10 : 0),
            dense: true,
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: contact.profilePic.isNotEmpty
                  ? NetworkImage(contact.profilePic, scale: 1)
                  : null,
              backgroundColor: context.theme.greyColor!.withOpacity(0.3),
              child: contact.profilePic.isEmpty
                  ? const Icon(Icons.person, size: 30)
                  : const SizedBox(),
            ),

            // ---- title of the contact list---

            title: Text(
              contact.name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),

            subtitle: Text(
              isPhoneContact
                  ? contact.phoneNumber
                  : "Hey there! I am using whatApp",
              style: TextStyle(
                  color: context.theme.greyColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),

            // ---- trailing of the contact list for phone contact only---

            trailing: isPhoneContact
                ? TextButton(
                    onPressed: () => shareSMS(contact.phoneNumber),

                    // ---- style of the trailing button---

                    style: TextButton.styleFrom(
                        backgroundColor:
                            context.theme.greyColor!.withOpacity(0.2),
                        foregroundColor: ThemeColors.greenDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: const Text(
                      "Invite",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
