import 'package:cloud_firestore/cloud_firestore.dart';

class ContractRepository {
  final FirebaseFirestore _firebaseFirestore;

  ContractRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;
}
