import 'package:flutter/material.dart';
import 'package:whatapp_clone/common/common.dart';
import 'package:whatapp_clone/features/auth/pages/image_picker_view.dart';
import 'package:whatapp_clone/features/auth/widgets/custom_text_field.dart';
import 'package:whatapp_clone/features/auth/widgets/image_picker_icon.dart';
import 'package:whatapp_clone/features/auth/widgets/short_h_bar.dart';
import 'package:whatapp_clone/theme/custom_theme_extenstion.dart';

class UserInformationView extends StatefulWidget {
  const UserInformationView({Key? key}) : super(key: key);

  @override
  _UserInformationViewState createState() => _UserInformationViewState();
}

class _UserInformationViewState extends State<UserInformationView> {
// -----controller name -----

  final name_controller = TextEditingController();

  // ------- image picker type bottomsheet------\
  imagePickerTypeBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            // mainAxisSize: MainAxisSize.min,
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
                      onTap: () {}),
                  const SizedBox(
                    width: 30,
                  ),
                  ImagePickerIcon(
                      icon: Icons.photo_library_rounded,
                      title: 'Gallery',
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ImagePickerView(),
                          ),
                        );
                      })
                ],
              )
            ],
          );
        });
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
              ),
              child: Icon(
                Icons.add_a_photo_rounded,
                size: 48,
                color: context.theme.photoIconColor,
              ),
            ),
          ),
          // -------- name textfield-----

          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: TextEditingController(),
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
      floatingActionButton:
          CustomElevatedButton(onPressed: () {}, label: "Next"),
    );
  }
}
