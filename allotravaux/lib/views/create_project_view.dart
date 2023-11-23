import 'package:allotravaux/bloc/projects/project_bloc.dart';
import 'package:allotravaux/bloc/projects/project_state.dart';
import 'package:allotravaux/components/button_component.dart';
import 'package:allotravaux/components/navigation_bar_component.dart';
import 'package:allotravaux/views/project_view.dart';
import 'package:allotravaux/views/type_artisan_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../resources/background_decoration.dart';
import '../resources/style.dart';
import '../store/project.dart';

class CreateProjectsView extends StatelessWidget {
  const CreateProjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: bodyBackgroundHigh,
            elevation: 0,
            toolbarHeight: 100,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () =>
                    Navigator.of(context).push(createRoute(ProjectsView()))),
            title: const Text(
              "Créez votre projet",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
            ),
            centerTitle: true,
          ),
          body: Container(
              decoration: bodyBackgroundDecoration,
              height: double.infinity,
              child: const SingleChildScrollView(child: CreateProjectForm())));
    });
  }
}

class CreateProjectForm extends StatefulWidget {
  const CreateProjectForm({super.key});

  static const labelStyle = TextStyle(color: Colors.white, fontSize: 13);

  @override
  State<CreateProjectForm> createState() => _CreateProjectFormState();
}

class _CreateProjectFormState extends State<CreateProjectForm> {
  // final ProjectStore store = MyApp.projectStore;
  final _formKey = GlobalKey<FormState>();

  Project? project;

  final TextEditingController titleProject = TextEditingController();

  final TextEditingController descriptionProject = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      // Build a Form widget using the _formKey created above.
      return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 0, 5),
                child: Text("Renseignez un titre",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
                  child: Text("Cet intitulé pourra être modifié.",
                      style: CreateProjectForm.labelStyle)),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  controller: titleProject,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Color(0xff0b1d4e)),
                  decoration: InputDecoration(
                    fillColor: secondaryLightButton,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: secondaryLightButton)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                        borderSide: BorderSide(color: secondaryLightButton)),
                    focusColor: secondaryLightButton,
                    filled: true,
                    iconColor: primaryLightButton,
                    hintText: 'Exemple : Réparation de la douche',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return "Veuillez renseigner un titre d'au moins 5 caractères.";
                    }
                    return null;
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 40, 0, 5),
                child: Text("Renseignez une description",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 0, 20),
                child: Text(
                    "Attention : cette description doit être précise, complète et claire. Elle sera lue par l’artisan.",
                    style: CreateProjectForm.labelStyle),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextFormField(
                  controller: descriptionProject,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  maxLines: 20,
                  minLines: 5,
                  decoration: InputDecoration(
                    fillColor: secondaryLightButton,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: secondaryLightButton)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: secondaryLightButton)),
                    focusColor: secondaryLightButton,
                    filled: true,
                    iconColor: primaryLightButton,
                    hintText:
                        "Exemple : Le robinet fuit et le pommeau de douche a un problème de débit. L’eau s’écoule mal et une odeur nauséabonde se dégage de l’évacuation d’eau.",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 5) {
                      return 'Veuillez renseigner ce champ.';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 22.0),
                child: Center(
                    child: SizedBox(
                        width: 250.0,
                        child: ButtonComponent(
                          text: "Suivant >",
                          onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {
                                Navigator.of(context).push(createRoute(
                                    TypeArtisanView(
                                        descriptionProject:
                                            descriptionProject.text,
                                        titleProject: titleProject.text)))
                              }
                          },
                          buttonSize: const Size(double.infinity, 45),
                        ))),
              ),
            ],
          ),
        ),
      );
    });
  }
}
