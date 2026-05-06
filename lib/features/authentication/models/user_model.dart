import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String username;
  final String licenceKey;
  final String role; // admin, operateur
  final List<String> pompesAutorisees;
  final DateTime? createdAt;
  final DateTime? lastLogin;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.licenceKey,
    this.role = 'operateur',
    this.pompesAutorisees = const [],
    this.createdAt,
    this.lastLogin,
  });

  // Depuis Firestore
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return UserModel(
      uid: doc.id,
      email: data['email']?? '',
      username: data['username']?? '',
      licenceKey: data['licenceKey']?? '',
      role: data['role']?? 'operateur',
      pompesAutorisees: List<String>.from(data['pompesAutorisees']?? []),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      lastLogin: (data['lastLogin'] as Timestamp?)?.toDate(),
    );
  }

  // Vers Firestore
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'licenceKey': licenceKey,
      'role': role,
      'pompesAutorisees': pompesAutorisees,
      'createdAt': createdAt?? FieldValue.serverTimestamp(),
      'lastLogin': FieldValue.serverTimestamp(),
    };
  }

  UserModel copyWith({
    String? username,
    String? role,
    List<String>? pompesAutorisees,
  }) {
    return UserModel(
      uid: uid,
      email: email,
      username: username?? this.username,
      licenceKey: licenceKey,
      role: role?? this.role,
      pompesAutorisees: pompesAutorisees?? this.pompesAutorisees,
      createdAt: createdAt,
      lastLogin: lastLogin,
    );
  }
}