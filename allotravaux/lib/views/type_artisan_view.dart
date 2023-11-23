
import 'package:allotravaux/views/create_project_view.dart';
import 'package:allotravaux/views/recap_project_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../bloc/projects/project_bloc.dart';
import '../bloc/projects/project_event.dart';
import '../bloc/projects/project_state.dart';
import '../components/navigation_bar_component.dart';
import 'package:allotravaux/resources/style.dart';
import '../store/project.dart';

class TypeArtisanView extends StatefulWidget {
  final String titleProject;
  final String descriptionProject;
  String? typeArtisan;
  TypeArtisanView(
      {super.key,
      required this.titleProject,
      required this.descriptionProject});

  @override
  State<TypeArtisanView> createState() => _TypeArtisanViewState();
}

class _TypeArtisanViewState extends State<TypeArtisanView> {
  bool initText = false;

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(25),
                  child: Text('Êtes vous sûr de votre choix ?'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Text('Une fois validé, le type d\'artisan associé à votre projet ne pourra pas être modifié !'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Non', style: TextStyle(color: bodyBackgroundHigh)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Oui', style: TextStyle(color: bodyBackgroundHigh)),
              onPressed: () {
                widget.typeArtisan ??= "Cordonnier";
                var project = Project(
                    id: const Uuid().v4(),
                    title: widget.titleProject,
                    description: widget.descriptionProject,
                    state: "En attente",
                    typeArtisan: widget.typeArtisan!);
                context.read<ProjectBloc>().add(AddProject(project: project));

                Fluttertoast.showToast(
                    msg: "Votre projet a été correctement ajouté.",
                    fontSize: 18,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.green,
                    textColor: Colors.black);
                Navigator.of(context).push(createRoute(RecapProjectView(
                  project: project,
                )));
              },
            ),
          ],
        );
      },
    );
  }

  late int selectedIndex = 0;
  int selectedItemIndex = 0;

  @override
  Widget build(BuildContext context) {

    double listContainerHeight = MediaQuery.of(context).size.height - 150;

    const double listContainerBorderWidth = 1.5;
    const int itemsCount = 8;
    double itemHeight = (listContainerHeight - listContainerBorderWidth * 2) / itemsCount;

    var typesList = ["Cordonnier", "Carreleur", "Cuisiniste", "Jardinier", "Plombier", "Pisciniste", "Chauffagiste", "Peintre", "Maçon", "Menuisier", "Bûcheron"];

    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection('ArtisanTypes').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return Scaffold(
              appBar: AppBar(
                backgroundColor: bodyBackgroundHigh,
                elevation: 0,
                toolbarHeight: 100,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () =>
                        Navigator.of(context).push(createRoute(const CreateProjectsView()))),
                title: const Text(
                  "Type d'artisan",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                ),
                centerTitle: true,
              ),
              body: Container(
                color: bodyBackgroundHigh,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        top: selectedItemIndex * 58,
                        left: 0,
                        right: 0,
                        height: itemHeight,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              typesList.length,
                              (i) => Expanded(
                                child: InkWell(
                                  onTap: () => setState(() {
                                    selectedItemIndex = i;
                                    widget.typeArtisan = typesList[i];
                                  } ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        typesList[i],
                                        style: const TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ), 
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
              floatingActionButton: FloatingActionButton(
                  backgroundColor: primaryLightButton,
                  onPressed: () async => {showMyDialog(context)},
                  child: const Icon(Icons.arrow_forward_ios, color: Colors.black),
                ),
              );
          });
    });
  }
}
