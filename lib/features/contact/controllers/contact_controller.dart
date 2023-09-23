import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatapp_clone/features/contact/repository/contacts_repository.dart';
import 'package:whatapp_clone/models/user_model.dart';

final getContactProvider = FutureProvider((ref) {
  final selectedContact = ref.watch(selectContactsRepositoryProvider);
  return selectedContact.getAllContacts2();
});

final getFirebaseContactProvider = FutureProvider<List<UserModel>>((ref) async {
  final selectedContact = ref.watch(selectContactsRepositoryProvider);
  return selectedContact.getFirebaseContact();
});

final getContactLength = Provider((ref) {
  final selectedContact = ref.watch(getContactProvider);

  return selectedContact.when(
    data: (value) => value[0].length + value[1].length,
    loading: () => 0,
    error: (error, stackTrace) => 0,
  );
});
