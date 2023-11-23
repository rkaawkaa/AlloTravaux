import 'package:cloud_firestore/cloud_firestore.dart';

enum ProjectCondition { ongoing, awaiting, over }

class Project {
  late final String id;
  late final String title;
  late final String description;
  String state;
  final String typeArtisan;

  Project(
      {required this.id,
      required this.title,
      required this.description, 
      required this.state,
      required this.typeArtisan});

  factory Project.fromDocument(DocumentSnapshot doc) {
    String id = doc.get('id');
    String title = doc.get('title');
    String description = doc.get('description').toString();
    String state = doc.get('state');
    return Project(id: id, title: title, description: description, state: state, typeArtisan: doc.get('typeArtisan'));
  }
}
