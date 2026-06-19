import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore _db =
      FirebaseFirestore.instance;

  Future<void> createUser({
    required String uid,
    required String email,
    required String name,
  }) async {
    await _db.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'createdAt': Timestamp.now(),
    });
  }
}