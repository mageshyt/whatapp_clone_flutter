import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseStorageProvider = Provider((ref) =>
    CommonFirebaseStorageRepository(firebaseStorage: FirebaseStorage.instance));

class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;
  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  // store file to firebase
  storeFileToFirebase(String ref, var file) async {
    UploadTask? uploadTask;

    if (file is File) {
      uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    }
    if (file is Uint8List) {
      // type should be image/jpeg
      uploadTask = firebaseStorage
          .ref()
          .child(ref)
          .putData(file, SettableMetadata(contentType: 'image/jpeg'));
    }

    TaskSnapshot snapshot = await uploadTask!;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }
}
