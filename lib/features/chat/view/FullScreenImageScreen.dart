import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/widgets/reuse_appbar.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl; // Assuming the image is passed as a URL
  final String title;
  const FullScreenImageScreen(
      {super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: ReuseableAppbar(
        title: title,
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      body: Center(
        child: Image.network(
          height: 300,
          width: double.infinity,
          imageUrl,
          filterQuality: FilterQuality.high,
          scale: 1,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
