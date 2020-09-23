import 'package:app/constants/enums.dart';
import 'package:app/models/phase.dart';
import 'package:app/models/project.dart';
import 'package:app/models/project_preview.dart';
import 'package:app/models/stock_item.dart';
import 'package:app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Stream<QuerySnapshot> getProjectsStream(QPUser user) {
  Stream<QuerySnapshot> stream;
  stream = firestore.collection('preview').snapshots();
  return stream;
}

Stream<QuerySnapshot> getPhasesStream(DocumentReference project) {
  Stream<QuerySnapshot> stream;
  stream = project.collection('phases').orderBy('id').snapshots();
  return stream;
}

Stream<QuerySnapshot> getStockStream(CollectionReference phase) {
  Stream<QuerySnapshot> stream;
  stream = phase.snapshots();
  return stream;
}

Future<bool> createProject(Project project, QPUser user) async {
  try {
    DocumentReference reference =
        await firestore.collection('data').add(project.toJson());
    ProjectPreview preview =
        ProjectPreview(project.title, reference, QPState.onTrack, user.name);
    await firestore
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

Future<bool> removeStockItem(StockItem stockItem) async {
  try {
    await stockItem.reference.delete();
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

Future<DocumentReference> createPhase(
    DocumentReference projectReference, int id) async {
  try {
    DocumentReference phaseRef =
        await projectReference.collection('phases').add({
      'id': id,
    });
    return phaseRef;
  } catch (e) {
    return null;
  }
}

Future<bool> cancelPhaseCreation(DocumentReference phaseReference) async {
  try {
    await phaseReference.delete();
    return true;
  } catch (error) {
    return false;
  }
}

Future<bool> confirmPhaseCreation(DocumentReference projectReference, int id,
    DocumentReference phaseReference, Phase phase) async {
  try {
    await phaseReference.update(phase.toJson());
    await projectReference.update({
      'phases': id,
    });
    await firestore.collection('preview').doc(projectReference.id).update({
      'phase': phase.title,
      'state': 'onTrack',
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> finishPhase(
    QPUser user, DocumentReference phaseReference, String previewId) async {
  try {
    await phaseReference.update({
      'eta': 0,
      'state': 'finished',
    });
    await firestore.collection('preview').doc(previewId).update({
      'state': 'finished',
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<Project> getProjectData(DocumentReference reference) async {
  DocumentSnapshot projectSnapshot = await reference.get();
  Project project = Project.fromJson(projectSnapshot.data());
  return project;
}
