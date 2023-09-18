import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/common/widgets/reuse_appbar.dart';
import 'package:whatapp_clone/constants/colors.dart';

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReuseableAppbar(
        title: 'Select contact',
        subText: '256 contact',
        isCenterTitle: false,
        backgroundColor: ThemeColors.greyBackground,
        actions: [
          CustomIconButton(icon: Icons.search, onPressed: () {}),
          CustomIconButton(icon: Icons.more_vert, onPressed: () {})
        ],
      ),
    );
  }
}
