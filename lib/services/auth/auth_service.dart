import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //get instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //get current user
  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }

  //sign in
Future<UserCredential> signInWithEmailPassword(
  String email,
  String password,
) async {
  final cred = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final user = cred.user;

  if (user != null) {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    final doc = await userRef.get();

    if (!doc.exists) {
      await userRef.set({
        'email': user.email,
        'role': 'user',
        'createdAt': DateTime.now(),
      });
    }
  }

  return cred;
}

  //sign up
Future<UserCredential> signUpWithEmailPassword(
  String email,
  String password,
) async {
  final cred = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  // 🔥 thêm đoạn này
  await FirebaseFirestore.instance
      .collection('users')
      .doc(cred.user!.uid)
      .set({
    'email': email,
    'role': 'user',
    'createdAt': DateTime.now(),
  });

  return cred;
}

  //sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}