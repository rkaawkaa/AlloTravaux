import 'package:allotravaux/resources/style.dart';
import 'package:allotravaux/views/project_view.dart';
import 'package:allotravaux/views/search_artisan_view.dart';
import 'package:flutter/material.dart';
import '../components/navigation_bar_component.dart';
import '../resources/background_decoration.dart';
import '../store/project.dart';

class RecapProjectView extends StatelessWidget {
  final Project project;

  const RecapProjectView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    var typeArtisan = project.typeArtisan;
    var projectState = project.state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bodyBackgroundHigh,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () =>
                Navigator.of(context).push(createRoute(ProjectsView()))),
        title: Text(
          project.title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      body: Container(
          height: double.infinity,
          decoration: bodyBackgroundDecoration,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              "Projet : ${project.title}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text("Vous avez choisi de contacter un ",
                                style: TextStyle(
                                    color: primaryLightButton, fontSize: 15),
                                textAlign: TextAlign.left),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Text(
                              typeArtisan,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            Text(" pour votre projet.",
                                style: TextStyle(
                                    color: primaryLightButton, fontSize: 15),
                                textAlign: TextAlign.left),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          color: primaryLightButton,
                          height: 15,
                          thickness: 1,
                          indent: 2,
                          endIndent: 2,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Son statut : ",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            projectState,
                            style: TextStyle(
                                color: primaryLightButton, fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Divider(
                          color: primaryLightButton,
                          height: 15,
                          thickness: 1,
                          indent: 2,
                          endIndent: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: const [
                            Text(
                              "Sa description :",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(project.description,
                              style: TextStyle(
                                  color: primaryLightButton, fontSize: 15),
                              textAlign: TextAlign.left),
                        ),
                      )
                    ],
                  )),
            ]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: project.state != "Terminé"
          ? FloatingActionButton.extended(
              onPressed: () => {
                Navigator.of(context)
                    .push(createRoute(SearchArtisanView(project: project))),
              },
              label: const Text("Trouver un artisan",
                  style: TextStyle(color: Colors.black)),
              backgroundColor: primaryLightButton,
            )
          : null,
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}
