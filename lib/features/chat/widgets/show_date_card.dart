import 'package:flutter/material.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';
import 'package:intl/intl.dart';

class ShowDateCard extends StatelessWidget {
  const ShowDateCard({Key? key, required this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: context.theme.receiverChatCardBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        // if the date is today, show 'Today' instead of the date
        date.day == DateTime.now().day
            ? 'Today'
            : DateFormat.yMMMd().format(date),
      ),
    );
  }
}
