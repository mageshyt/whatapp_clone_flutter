// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/widgets/reuse_appbar.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({super.key});

  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

class _ImagePickerViewState extends State<ImagePickerView> {
  int current_page = 0;
  int? last_page;
  // handle pagination
  handleEventScroll(ScrollNotification scroll) {
    // debugPrint('scroll metrics: ${scroll.metrics}');
    if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
      if (current_page != last_page) {
        current_page++;
        fetchAllImages();
      }
    }
  }

  // ------ list of images ------

  List<Widget> images = [];

  fetchAllImages() async {
    last_page = current_page;
    // get the permission
    final permission = await PhotoManager.requestPermissionExtend();

    // if permission not granted
    if (!permission.isAuth) {
      // print('permission not granted');
      return PhotoManager.openSetting();
    }

    List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(onlyAll: true);

    // get all images

    List<AssetEntity> media =
        await albums[0].getAssetListPaged(page: current_page, size: 20);

    // convert to widget

    List<Widget> temp = [];

    // ignore: unused_local_variable
    for (var asset in media) {
      temp.add(
        FutureBuilder(
          // ignore: prefer_const_constructors
          future: asset.thumbnailDataWithSize(ThumbnailSize(200, 200)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return InkWell(
                onTap: () => Navigator.pop(context, snapshot.data),
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: context.theme.greyColor!.withOpacity(0.2),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: MemoryImage(snapshot.data as Uint8List),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      );
    }

    setState(() {
      images.addAll(temp);
    });
  }

  @override
  void initState() {
    print("init state called");
    fetchAllImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ReuseableAppbar(
        title: "whatsApp ",
        isCenterTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(6),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scroll) {
            handleEventScroll(scroll);
            return true;
          },
          child: GridView.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return images[index];
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              )),
        ),
      ),
    );
  }
}
