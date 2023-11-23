import 'package:allotravaux/bloc/projects/project_event.dart';
import 'package:allotravaux/bloc/projects/project_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../store/project.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectState(projectList: [], subList: [], subtitle: "En cours", ongoingIsSelected: true, overIsSelected: false)) {
    on(_onAddProject);
    on(_onDeleteProject);
    on(_onGetProjects);
    on(_onValidateProject);
    on(_onSelectOnGoing);
    on(_onSelectOver);
    on(_onUpdateStateList);
  }

  void _onGetProjects(GetProjects event, Emitter emit) {
      List<Project> newList = [];
      for (var project in event.data) {
        newList.add(Project.fromDocument(project));
      }
      state.subList = state.projectList;
      emit(state.copywith(projectList: newList, subList: newList
          .where((e) => e.state == "En attente")
          .toList(), onGoingIsSelected: true, overIsSelected: false, subtitle: "En cours"));

  }

  void _onUpdateStateList(UpdateStateList event, Emitter emit) {
    emit(state.copywith(projectList: state.projectList, subList: state.subList, onGoingIsSelected: state.ongoingIsSelected, overIsSelected: state.overIsSelected, subtitle: state.subtitle));
}

  Future<void> _onValidateProject(ValidateProject event, Emitter emit) async {

    var docToUpdate = await FirebaseFirestore.instance
        .collection("Projects")
        .where("id", isEqualTo: event.project.id)
        .get();
    await FirebaseFirestore.instance
        .collection("Projects")
        .doc(docToUpdate.docs.first.id)
        .update({"state": "Terminé"});
    state.projectList.remove(event.project);
    event.project.state = "Terminé";
    state.projectList.add(event.project);
    state.subList.remove(event.project);


    emit(state.copywith(projectList: state.projectList, subList: state.subList, onGoingIsSelected: state.ongoingIsSelected, overIsSelected: state.overIsSelected, subtitle: state.subtitle));
  }

  void _onAddProject(AddProject event, Emitter emit) {
    FirebaseFirestore.instance.collection('Projects').add({
      'id': event.project.id,
      'title': event.project.title,
      'description': event.project.description,
      'typeArtisan': event.project.typeArtisan,
      'state': event.project.state
    });
    List<Project> newList = state.projectList;
    newList.add(event.project);
    List<Project> newSubList = [];
    if (state.ongoingIsSelected = true) {
      newSubList = state.projectList
          .where((e) => e.state == "En attente")
          .toList();
    }
    else {
      state.projectList
          .where((e) => e.state != "En attente")
          .toList();
    }
    emit(state.copywith(projectList: newList, subList: newSubList, onGoingIsSelected: state.ongoingIsSelected, overIsSelected: state.overIsSelected, subtitle: state.subtitle));
  }

  Future<void> _onDeleteProject(DeleteProject event, Emitter emit) async {
    List<Project> newList = state.projectList;
    newList.remove(event.project);
    var docToDelete = await FirebaseFirestore
        .instance
        .collection("Projects")
        .where("title",
        isEqualTo: event.project.title)
        .where("description",
        isEqualTo: event.project.description)
        .get();
    FirebaseFirestore.instance
        .collection("Projects")
        .doc(docToDelete.docs.first.id)
        .delete();

    emit(state.copywith(projectList: newList, subList: newList, onGoingIsSelected: state.ongoingIsSelected, overIsSelected: state.overIsSelected, subtitle: state.subtitle));
  }

  void _onSelectOnGoing(SelectOnGoing event, Emitter emit) {
    var list = state.projectList
        .where((e) => e.state == "En attente")
        .toList();
    emit(state.copywith(projectList: state.projectList, subList: list, overIsSelected: false, onGoingIsSelected: true, subtitle: "En cours"));
  }

  void _onSelectOver(SelectOver event, Emitter emit) {
    var list = state.projectList
        .where((e) => e.state != "En attente")
        .toList();
    emit(state.copywith(projectList: state.projectList, subList: list, overIsSelected: true, onGoingIsSelected: false, subtitle: "Terminé"));
  }
}
