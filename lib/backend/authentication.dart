import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
QuickPlannerUser currentSignedInUser;

Future<QuickPlannerUser> signIn(email, password) async {
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
  updateCurrentSignedInUser(userCredential.user, userSnapshot);
  return currentSignedInUser;
}

Future<QuickPlannerUser> signUp(
    email, password, name, phone) async {
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

  currentSignedInUser = QuickPlannerUser(
      email: email, name: name, phone: phone, uid: userCredential.user.uid);
  print('currentSignedInUser' + currentSignedInUser.toString());
  await firestore
      .collection('users')
      .doc(userCredential.user.uid)
      .set(currentSignedInUser.toMap());
  return currentSignedInUser;
}

Future<bool> recoverWithFirebase(email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email);
    return true;
  } catch (error) {
    return false;
  }
}

void updateCurrentSignedInUser(User user, DocumentSnapshot userSnapshot) {
  print("updating email");
  currentSignedInUser = QuickPlannerUser.fromMap(user.uid, userSnapshot.data());
}

Future<bool> signOutFirebase() async {
  currentSignedInUser = null;
  await _auth.signOut();
  return true;
}
