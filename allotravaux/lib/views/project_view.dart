import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/projects/project_bloc.dart';
import '../bloc/projects/project_event.dart';
import '../bloc/projects/project_state.dart';
import '../components/navigation_bar_component.dart';
import '../resources/background_decoration.dart';
import 'package:allotravaux/components/project_card_component.dart';
import '../store/project.dart';
import '/assets/my_flutter_app_icons.dart';
import 'package:allotravaux/components/button_component.dart';
import 'create_project_view.dart';

class ProjectsView extends StatelessWidget {
  ProjectsView({super.key});
  bool initText = false;

  String? title;

  visibilityText(list) {
    if (list.isEmpty) {
      title = "Allo'Travaux";
      return initText = true;
    } else {
      title = "Vos projets";
      return initText = false;
    }
  }

  var projects = [];

  IconData setStateIcon(Project project) {
    IconData icon;
    switch (project.state) {
      case ("Terminé"):
        icon = MyFlutterApp.travailFini;
        break;
      case ("En cours"):
        icon = MyFlutterApp.maison;
        break;
      default:
        icon = MyFlutterApp.maison;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Projects').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.projectList.isEmpty) {
              context
                  .read<ProjectBloc>()
                  .add(GetProjects(data: snapshot.data.docs));
            }

            visibilityText(state.projectList);
            return Scaffold(
              body: Container(
                decoration: bodyBackgroundDecoration,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(
                            top: 55, bottom: initText ? 60 : 10),
                        child: Text(title!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30))),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: Visibility(
                        visible: initText,
                        child: const Text(
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            textAlign: TextAlign.justify,
                            "Vous n’avez pas encore de projets.\nVous devez en créer un avant de pouvoir contacter un artisan.\n\nCliquez sur le bouton d'ajout ci-dessous pour en créer un!"),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      height: 90,
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Visibility(
                        visible: !initText,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ButtonComponent(
                                    icon: Icons.add,
                                    text: "En cours",
                                    isSelected: state.ongoingIsSelected,
                                    onPressed: () {
                                      context
                                          .read<ProjectBloc>()
                                          .add(SelectOnGoing());
                                    }),
                                const SizedBox(width: 10),
                                ButtonComponent(
                                    icon: Icons.add,
                                    text: "Terminé",
                                    isSelected: state.overIsSelected,
                                    onPressed: () {
                                      context
                                          .read<ProjectBloc>()
                                          .add(SelectOver());
                                    }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !initText,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          state.subtitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: state.subList.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                key: UniqueKey(),
                                onDismissed: ((direction) {
                                  context.read<ProjectBloc>().add(DeleteProject(
                                      project: state.subList[index]));
                                  context.read<ProjectBloc>().add(
                                      GetProjects(data: snapshot.data.docs));

                                  Fluttertoast.showToast(
                                      msg: "Votre projet a été supprimé.",
                                      fontSize: 18,
                                      gravity: ToastGravity.TOP,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.black);
                                }),
                                child: ProjectCardComponent(
                                  title: state.subList[index].title,
                                  subtitle:
                                      "Artisan : ${state.subList[index].state}",
                                  icon: setStateIcon(state.subList[index]),
                                  data: state.subList[index],
                                ),
                              );
                            })),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(right: 7),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context)
                        .push(createRoute(const CreateProjectsView()));
                  },
                  child: const Icon(Icons.add, color: Colors.black),
                ),
              ),
              bottomNavigationBar: const NavigationBarComponent(),
            );
          });
    });
  }
}
