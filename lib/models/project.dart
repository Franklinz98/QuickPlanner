import 'package:app/models/phase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  final String title, description;
  int phasesQuantity;
  DocumentReference reference;

  Project(this.title, this.description,
      {this.phasesQuantity = 0, this.reference});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      json['title'],
      json['description'],
      phasesQuantity: json['phases'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'description': this.description,
      'phases': this.phasesQuantity,
    };
  }
}
