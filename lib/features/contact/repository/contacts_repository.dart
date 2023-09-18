import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/models/user_model.dart';

final selectContactsRepositoryProvider = Provider(
    (ref) => ContractRepository(firebaseFirestore: FirebaseFirestore.instance));

class ContractRepository {
  final FirebaseFirestore firestore;

  ContractRepository({FirebaseFirestore? firebaseFirestore})
      : firestore = firebaseFirestore ?? FirebaseFirestore.instance;

  // get contact

  Future<List<List<UserModel>>> getAllContacts2() async {
    List<UserModel> firebaseContacts = [];
    List<UserModel> phoneContacts = [];
    debugPrint("getting                          contacts");
    try {
      // Request permission to access phone contacts
      if (await FlutterContacts.requestPermission()) {
        // Fetch contacts from Firebase
        final userCollection = await firestore.collection('users').get();
        final firebaseContactList = userCollection.docs
            .map((doc) => UserModel.fromMap(doc.data()))
            .toList();

        debugPrint('firebaseContactList ${firebaseContactList[0].toMap()}');

        // Fetch contacts from the phone
        final allContactsInThePhone = await FlutterContacts.getContacts(
          withProperties: true,
        );

        // Iterate through phone contacts
        for (var contact in allContactsInThePhone) {
          bool isContactFound = false;
          debugPrint('contact ${contact.phones[0].number.replaceAll(' ', '')}');
          // Check if the phone contact exists in Firebase
          for (var firebaseContact in firebaseContactList) {
            if (contact.phones[0].number.replaceAll(' ', '') ==
                firebaseContact.phoneNumber) {
              firebaseContacts.add(firebaseContact);
              isContactFound = true;
              break;
            }
          }

          // If not found in Firebase, add to phoneContacts
          if (!isContactFound) {
            phoneContacts.add(
              UserModel(
                name: contact.displayName,
                uid: '',
                profilePic: '',
                isOnline: false,
                lastSeen: 0,
                phoneNumber: contact.phones[0].number.replaceAll(' ', ''),
                groupId: [],
              ),
            );
          }
        }
      }
    } catch (e) {
      log('Error: $e');
      // Handle errors here
    }

    return [firebaseContacts, phoneContacts];
  }
}
