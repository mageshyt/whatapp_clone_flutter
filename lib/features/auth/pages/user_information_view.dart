import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/common/helper/show_alert_dialog.dart';
import 'package:whatapp_clone/features/auth/controllers/auth_controller.dart';
import 'package:whatapp_clone/features/auth/pages/image_picker_view.dart';
import 'package:whatapp_clone/features/auth/widgets/custom_text_field.dart';
import 'package:whatapp_clone/features/auth/widgets/image_picker_icon.dart';
import 'package:whatapp_clone/features/auth/widgets/short_h_bar.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class UserInformationView extends ConsumerStatefulWidget {
  const UserInformationView({Key? key}) : super(key: key);

  @override
  _UserInformationViewState createState() => _UserInformationViewState();
}

class _UserInformationViewState extends ConsumerState<UserInformationView> {
  // ------ image ------
  File? imageCamera;
  Uint8List? imageGallery;

// -----controller name -----

  late TextEditingController usernameController;

  // --- function to save user data
  saveUserDataToFirebase() async {
    String username = usernameController.text;
    print(username);
    if (username.isEmpty) {
      return showAlertDialog(
          context: context, content: 'Please provide a username');
    } else if (username.length < 3 || username.length >= 20) {
      return showAlertDialog(
          context: context,
          content: 'A username length should be between 3-20');
    }

    ref.read(authControllerProvider).saveUserInfo(
        username: username,
        profileImage: imageCamera ?? imageGallery ?? '',
        context: context,
        mounted: mounted);
  }

  // ------- image picker type bottomsheet------\
  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ShortHBar(
                width: 50,
              ),
              // ------ title ------
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Text("Profile Photo",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    const Spacer(),
                    // ------ close icon ------
                    CustomIconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: (Icons.close),
                      iconsColor: context.theme.greyColor,
                      iconSize: 30,
                    ),
                  ],
                ),
              ),

              // -------- Divider ------
              Divider(
                color: context.theme.greyColor!.withOpacity(0.2),
              ),
              // ------ camera ------
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  ImagePickerIcon(
                      icon: Icons.camera_alt_rounded,
                      title: 'Camera',
                      onTap: pickImageFromCamera),
                  const SizedBox(
                    width: 30,
                  ),
                  ImagePickerIcon(
                      icon: Icons.photo_library_rounded,
                      title: 'Gallery',
                      onTap: () async {
                        Navigator.of(context).pop();
                        final image = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ImagePickerView(),
                          ),
                        );

                        if (image != null) {
                          setState(() {
                            imageGallery = image as Uint8List?;
                            imageCamera = null;
                          });
                        }
                      })
                ],
              ),
              const SizedBox(
                height: 60,
              )
            ],
          );
        });
  }

// ----- capture image -----

  pickImageFromCamera() async {
    Navigator.of(context).pop();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        imageCamera = imageTemporary;
        imageGallery = null;
      });
    } catch (e) {
      showAlertDialog(context: context, content: e.toString(), title: 'Error');
    }
  }

  @override
  void initState() {
    usernameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text("profile info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          // -------- info text-----
          Text(
            'Please provide your name and an optional profile photo',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.theme.greyColor,
            ),
          ),

          // -------- profile photo-----

          const SizedBox(height: 30),

          GestureDetector(
            onTap: imagePickerTypeBottomSheet,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: context.theme.photoIconBgColor,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: imageCamera == null && imageGallery == null
                        ? context.theme.photoIconColor!.withOpacity(0.5)
                        : Colors.transparent,
                    width: 2,
                  ),
                  image: imageCamera != null || imageGallery != null
                      ? DecorationImage(
                          image: imageCamera != null
                              ? FileImage(imageCamera!)
                              : MemoryImage(imageGallery!) as ImageProvider,
                          fit: BoxFit.cover,
                        )
                      : null),
              child: imageCamera == null && imageGallery == null
                  ? Icon(
                      Icons.add_a_photo_rounded,
                      size: 48,
                      color: context.theme.photoIconColor,
                    )
                  : null,
            ),
          ),
          // -------- name textfield-----

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: usernameController,
                  hintText: 'Enter your name',
                  textAlign: TextAlign.left,
                ),
              ),

              // Emoji icon

              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.emoji_emotions_outlined,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ],
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomElevatedButton(
          onPressed: saveUserDataToFirebase, label: "Next"),
    );
  }
}
