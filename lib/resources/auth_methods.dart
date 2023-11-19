import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String department,
    required String rollNo,
    required String name,
  }) async {
    if (department == 'Select your Department') {
      return 'Select your Department';
    }
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        rollNo.isNotEmpty &&
        name.isNotEmpty) {
      var userSnap = await _firestore
          .collection('users')
          .where('rollNo', isEqualTo: rollNo)
          .get();
      int userLen = userSnap.docs.length;
      if (userLen > 0) {
        return 'Roll Number already exists';
      }
      userSnap = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      userLen = userSnap.docs.length;
      if (userLen > 0) {
        return 'Email already exists';
      }
      try {
        // register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        model.User user = model.User(
            email: email,
            uid: cred.user!.uid,
            password: password,
            name: name,
            department: department,
            rollNo: rollNo);

        // add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        return 'succes';
      } catch (e) {
        return e.toString();
      }
    }
    return 'Some Fields have to be fill';
  }

  // Get user
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // login user
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return 'succes';
      } catch (e) {
        return e.toString();
      }
    }
    return 'Some fields have to be fill';
  }

  Future<void> logOut() async {
    _auth.signOut();
  }
}
