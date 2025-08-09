import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/package.dart';

class PackagesRepo {
  static final _db = FirebaseFirestore.instance;

  static Stream<List<JVPackage>> streamMyPending(List<String> apartmentIds) {
    return _db.collection('packages')
      .where('apartmentId', whereIn: apartmentIds.isEmpty ? ['__none__'] : apartmentIds)
      .where('status', isEqualTo: 'received')
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => JVPackage.fromMap(d.id, d.data())).toList());
  }

  static Stream<List<JVPackage>> streamMyPicked(List<String> apartmentIds) {
    return _db.collection('packages')
      .where('apartmentId', whereIn: apartmentIds.isEmpty ? ['__none__'] : apartmentIds)
      .where('status', isEqualTo: 'picked_up')
      .orderBy('pickedUpAt', descending: true)
      .snapshots()
      .map((snap) => snap.docs.map((d) => JVPackage.fromMap(d.id, d.data())).toList());
  }

  static Future<void> markPickedUp(String id, String userId) async {
    await _db.collection('packages').doc(id).update({
      'status': 'picked_up',
      'pickedUpAt': FieldValue.serverTimestamp(),
      'pickedUpBy': userId,
    });
  }

  static Future<Map<String, dynamic>?> getById(String id) async {
    final doc = await _db.collection('packages').doc(id).get();
    return doc.data();
  }
}
