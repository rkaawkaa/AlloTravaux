import 'package:allotravaux/store/project.dart';

class ProjectState {
  List<Project> projectList;
  List<Project> subList; //liste filtrée
  // final ProjectStore store = MyApp.projectStore;
  bool ongoingIsSelected = true;
  bool overIsSelected = false;
  String subtitle = "En cours";

  ProjectState({required this.projectList, required this.subList, required this.ongoingIsSelected, required this.overIsSelected, required this.subtitle});

  ProjectState copywith({required List<Project> projectList, required List<Project> subList, required bool onGoingIsSelected, required bool overIsSelected, required String subtitle}) {
    return ProjectState(projectList: projectList, subList: subList, ongoingIsSelected: onGoingIsSelected, overIsSelected: overIsSelected, subtitle: subtitle);
  }
}
