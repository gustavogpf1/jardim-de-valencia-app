import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static Future<User?> signIn(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user;
  }

  static String? get uid => _auth.currentUser?.uid;

  static Future<List<String>> getUserApartmentIds() async {
    final uid = _auth.currentUser!.uid;
    final doc = await _db.collection('users').doc(uid).get();
    final data = doc.data() ?? {};
    final apartments = (data['apartments'] as List?)?.cast<String>() ?? [];
    return apartments;
  }
}
