import 'package:app/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectPreview {
  final String title, phase, owner;
  final DocumentReference reference;
  final QPState state;

  const ProjectPreview(this.title, this.reference, this.state, this.owner,
      {this.phase = ''});

  factory ProjectPreview.fromJson(Map<String, dynamic> json) {
    QPState state;
    switch (json['state']) {
      case 'finished':
        state = QPState.finished;
        break;
      case 'onTrack':
        state = QPState.onTrack;
        break;
      case 'withProblems':
        state = QPState.withProblems;
        break;
    }
    return ProjectPreview(
      json['title'],
      json['ref'],
      state,
      json['owner'],
      phase: json['phase'],
    );
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'ref': this.reference,
        'state': _stateToString(this.state),
        'phase': this.phase,
        'owner': this.owner,
      };

  String _stateToString(QPState state) {
    switch (state) {
      case QPState.finished:
        return 'finished';
      case QPState.onTrack:
        return 'onTrack';
      case QPState.withProblems:
        return 'withProblems';
    }
    return '';
  }
}
