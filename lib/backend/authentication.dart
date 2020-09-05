/* import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_planner/models/user.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final db = FirebaseFirestore.instance;
QuickPlannerUser currentSignedInUser;

Future<QuickPlannerUser> signInWithFirebase(email, password) async {
  var fbuser;
  try {
    fbuser = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  } catch (error) {
    print('ERRORS');
    print(error.message.toString());
    print(error.code.toString());
    return null;
  }
  final DocumentSnapshot userSnapshot =
      await db.collection('users').doc(fbuser.uid).get();
  updateCurrentSignedInUser(fbuser, userSnapshot);
  return currentSignedInUser;
}

Future<QuickPlannerUser> signUpWithFirebase(
    email, password, name, phone) async {
  var fbUser;
  try {
    fbUser = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (error) {
    throw Exception(error.code);
  }
  if (fbUser.email == email) {
    try {
      var user = _auth.currentUser;
      user.updateProfile(displayName: name);
    } catch (error) {
      print(error);
      throw Exception(error.code);
    }
  } else {
    throw Exception('ERROR_SET_NAME');
  }

  currentSignedInUser =
      QuickPlannerUser(email: email, name: name, phone: phone, uid: fbUser.uid);
  print('currentSignedInUser' + currentSignedInUser.toString());
  await db.collection('users').doc(fbUser.uid).set(currentSignedInUser.toMap());
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
 */