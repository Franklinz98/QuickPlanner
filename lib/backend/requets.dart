import 'package:app/constants/enums.dart';
import 'package:app/models/project.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<List<ProjectPreview>> getProjectsFuture(QPUser user) async {
  List<ProjectPreview> projects = List();
  QuerySnapshot userSnapshot;
  userSnapshot = await firestore
      .collection('users')
      .doc(user.uid)
      .collection('preview')
      .get();
  userSnapshot.docs.forEach((document) {
    projects.add(ProjectPreview.fromJson(document.data()));
  });
  return projects;
}

Stream<QuerySnapshot> getProjectsStream(QPUser user) {
  Stream<QuerySnapshot> stream;
  if (user.admin) {
    stream = firestore.collection('preview').snapshots();
  } else {
    stream = firestore
        .collection('users')
        .doc(user.uid)
        .collection('preview')
        .snapshots();
  }
  return stream;
}

Future<bool> createProject(Project project, QPUser user) async {
  firestore.collection('data').add(project.toJson()).then((ref) {
    ProjectPreview preview =
        ProjectPreview(project.title, ref, QPState.onTrack, user.name);
    firestore
        .collection('preview')
        .doc(ref.id)
        .set(preview.toJson())
        .then((value) => firestore
                .collection('users')
                .doc(user.uid)
                .collection('preview')
                .doc(ref.id)
                .set(preview.toJson())
                .then((value) {
              return true;
            }).catchError((error) {
              return false;
            }))
        .catchError((error) {
      return false;
    });
  }).catchError((error) {
    return false;
  });
  return false;
}
