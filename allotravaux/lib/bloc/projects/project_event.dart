import 'package:allotravaux/store/project.dart';

class ProjectEvent {}

class GetProjects extends ProjectEvent {
  final List data;
  GetProjects({required this.data});
}

class UpdateStateList extends ProjectEvent{}

class AddProject extends ProjectEvent {
  final Project project;
  AddProject({required this.project});
}

class DeleteProject extends ProjectEvent {
  final Project project;
  DeleteProject({required this.project});
}

class ValidateProject extends ProjectEvent {
  final Project project;
  ValidateProject({required this.project});
}

class SendList extends ProjectEvent {}

class SelectOnGoing extends ProjectEvent {}

class SelectOver extends ProjectEvent {}

class SelectNoFilter extends ProjectEvent {}

