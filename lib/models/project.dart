
import 'package:app/models/phase.dart';

class Project {
  final String title, description;
  List<Phase> phases;

  Project(this.title, this.description, {this.phases}) {
    this.phases = List();
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    List<dynamic> phasesJson = json['phases'];
    List<Phase> phases = List();
    phasesJson.forEach((element) {
      phases.add(Phase.fromJson(element));
    });
    return Project(
      json['title'],
      json['description'],
      phases: phases,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> phasesJson = List();
    this.phases.forEach((phase) {
      phasesJson.add(phase.toJson());
    });
    return {
      'title': this.title,
      'description': this.description,
      'phases': phasesJson,
    };
  }
}
