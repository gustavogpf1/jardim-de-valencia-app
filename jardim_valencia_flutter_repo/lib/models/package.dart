class JVPackage {
  final String id;
  final String apartmentId;
  final String condoId;
  final String status;
  final DateTime createdAt;
  final DateTime? pickedUpAt;
  final String? photoUrl;
  final String? notes;

  JVPackage({
    required this.id,
    required this.apartmentId,
    required this.condoId,
    required this.status,
    required this.createdAt,
    this.pickedUpAt,
    this.photoUrl,
    this.notes,
  });

  factory JVPackage.fromMap(String id, Map<String, dynamic> m) {
    return JVPackage(
      id: id,
      apartmentId: m['apartmentId'],
      condoId: m['condoId'],
      status: m['status'],
      createdAt: (m['createdAt'] as dynamic).toDate(),
      pickedUpAt: m['pickedUpAt'] == null ? null : (m['pickedUpAt'] as dynamic).toDate(),
      photoUrl: m['photoUrl'],
      notes: m['notes'],
    );
  }
}
