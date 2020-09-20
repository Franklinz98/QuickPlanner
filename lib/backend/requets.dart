import 'package:app/constants/enums.dart';
import 'package:app/models/project.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/models/stock_item.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<List<ProjectPreview>> getProjectsFuture(QPUser user) async {
  List<ProjectPreview> projectsPreview = List();
  QuerySnapshot userSnapshot;
  userSnapshot = await firestore
      .collection('users')
      .doc(user.uid)
      .collection('preview')
      .get();
  userSnapshot.docs.forEach((previewSnapshot) {
    projectsPreview.add(ProjectPreview.fromJson(previewSnapshot.data()));
  });
  return projectsPreview;
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

Stream<QuerySnapshot> getPhasesStream(DocumentReference project) {
  Stream<QuerySnapshot> stream;
  stream = project.collection('phases').snapshots();
  return stream;
}

Stream<QuerySnapshot> getStockStream(CollectionReference phase) {
  Stream<QuerySnapshot> stream;
  stream = phase.snapshots();
  return stream;
}

Future<bool> createProject(Project project, QPUser user) async {
  try {
    DocumentReference reference = await firestore
        .collection('data')
        .add(project.toJson())
        .catchError(() {});
    ProjectPreview preview =
        ProjectPreview(project.title, reference, QPState.onTrack, user.name);
    await firestore
        .collection('preview')
        .doc(reference.id)
        .set(preview.toJson());
    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('preview')
        .doc(reference.id)
        .set(preview.toJson());
    return true;
  } catch (error) {
    return false;
  }
}

Future<bool> addStockItem(
    CollectionReference sotckReference, StockItem stockItem) async {
  try {
    await sotckReference.add(stockItem.toJson());
    return true;
  } catch (error) {
    return false;
  }
}

Future<bool> updateStock(StockItem stockItem) async {
  try {
    await stockItem.reference.update(stockItem.toJson());
    return true;
  } catch (error) {
    return false;
  }
}

Future<Project> getProjectData(DocumentReference reference) async {
  DocumentSnapshot projectSnapshot = await reference.get();
  Project project = Project.fromJson(projectSnapshot.data());
  return project;
}
