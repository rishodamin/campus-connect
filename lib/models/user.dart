import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String password;
  final String rollNo;
  final String name;
  final String department;

  const User({
    required this.email,
    required this.uid,
    required this.password,
    required this.name,
    required this.department,
    required this.rollNo,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'uid': uid,
        'password': password,
        'name': name,
        'department': department,
        'rollNo': rollNo,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      email: snapshot['email'],
      uid: snapshot['uid'],
      password: snapshot['password'],
      name: snapshot['name'],
      department: snapshot['department'],
      rollNo: snapshot['rollNo'],
    );
  }
}
