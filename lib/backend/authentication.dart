import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
QPUser currentSignedInUser;

User currentUser() {
  return _auth.currentUser;
}

Future<QPUser> signIn(email, password) async {
  UserCredential userCredential;
  try {
    userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  } catch (error) {
    print('ERRORS');
    print(error.message.toString());
    print(error.code.toString());
    return null;
  }
  final DocumentSnapshot userSnapshot =
      await firestore.collection('users').doc(userCredential.user.uid).get();
  currentSignedInUser =
      QPUser.fromMap(userCredential.user.uid, userSnapshot.data());
  return currentSignedInUser;
}

Future<QPUser> signUp(email, password, name, phone) async {
  UserCredential userCredential;
  try {
    userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (error) {
    throw Exception(error.code);
  }
  if (userCredential.user.email == email) {
    try {
      User user = _auth.currentUser;
      user.updateProfile(displayName: name);
    } catch (error) {
      print(error);
      throw Exception(error.code);
    }
  } else {
    throw Exception('ERROR_SET_NAME');
  }

  currentSignedInUser = QPUser(
      email: email, name: name, phone: phone, uid: userCredential.user.uid);
  print('currentSignedInUser' + currentSignedInUser.toString());
  await firestore
      .collection('users')
      .doc(userCredential.user.uid)
      .set(currentSignedInUser.toMap());
  return currentSignedInUser;
}

Future<bool> recover(email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    return true;
  } catch (error) {
    return false;
  }
}

Future<QPUser> getUserDetails(User user) async {
  final DocumentSnapshot userSnapshot =
      await firestore.collection('users').doc(user.uid).get();
  currentSignedInUser = QPUser.fromMap(user.uid, userSnapshot.data());
  return currentSignedInUser;
}

Future<bool> isAdmin(String uid) async {
  final DocumentSnapshot adminsSnapshot =
      await firestore.collection('users').doc("privileges").get();
  List admins = adminsSnapshot.data()['admins'];
  return admins.contains(uid);
}

Future<bool> signOut() async {
  currentSignedInUser = null;
  await _auth.signOut();
  return true;
}
