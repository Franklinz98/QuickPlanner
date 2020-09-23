import 'package:app/models/phase.dart';
import 'package:app/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuickPlannerModel extends ChangeNotifier {
  Project _project;
  Phase _phase;
  DocumentReference _projectReference, _phaseReference;
  bool _phasesState = false;

  Project get project => _project;
  Phase get phase => _phase;
  DocumentReference get projectRef => _projectReference;
  DocumentReference get phaseRef => _phaseReference;
  bool get phasesState => _phasesState;

  void updateProject(Project project) {
    _project = project;
  }

  void updatePhase(Phase phase) {
    _phase = phase;
  }

  void updateProjectReferece(DocumentReference reference) {
    _projectReference = reference;
  }

  void updatePhaseReference(DocumentReference reference) {
    _phaseReference = reference;
  }

  void resetPhasesState() {
    _phasesState = false;
  }

  void updatePhasesState(bool value) {
    _phasesState |= value;
  }
}
