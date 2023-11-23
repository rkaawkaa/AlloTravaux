import 'package:allotravaux/components/button_component.dart';
import 'package:allotravaux/components/navigation_bar_component.dart';
import 'package:allotravaux/store/project.dart';
import 'package:allotravaux/views/recap_project_view.dart';
import 'package:flutter/material.dart';
import 'package:allotravaux/resources/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../bloc/projects/project_bloc.dart';
import '../bloc/projects/project_event.dart';
import '../bloc/projects/project_state.dart';

class ProjectCardComponent extends StatelessWidget {
  final String? title;
  final String subtitle;
  final IconData? icon;
  final Project data;

  const ProjectCardComponent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.data,
  });

  String formatDate(DateTime date) {
    var formatter = DateFormat('dd-MM-yyyy');
    return "Projet terminé le ${formatter.format(date)}.";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
      Future<void> showMyDialog(BuildContext context, String title) async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              contentPadding: const EdgeInsets.only(top: 10.0),
              backgroundColor: secondaryLightButton,
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                          "Confirmez-vous que le projet '$title' est terminé ?"),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child:
                      Text('Non', style: TextStyle(color: bodyBackgroundHigh)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child:
                      Text('Oui', style: TextStyle(color: bodyBackgroundHigh)),
                  onPressed: () async {
                    context
                        .read<ProjectBloc>()
                        .add(ValidateProject(project: data));

                    Fluttertoast.showToast(
                        msg:
                            "Nous avons bien pris en compte que votre projet $title est terminé.",
                        fontSize: 18,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.green,
                        textColor: Colors.black);
                    Navigator.of(context).pop();
                    context.read<ProjectBloc>().add(UpdateStateList());
                  },
                ),
              ],
            );
          },
        );
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(createRoute(RecapProjectView(project: data)));
              },
              child: Card(
                color: secondaryLightButton,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        leading: Icon(icon, size: 60, color: Colors.black),
                        title: Text(title!,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600)),
                        subtitle: Text(
                            data.state == "Terminé"
                                ? formatDate(DateTime.now())
                                : subtitle,
                            style: const TextStyle(fontSize: 16))),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: data.state != "Terminé"
                            ? SizedBox(
                                width: 300.0,
                                child: ButtonComponent(
                                  text: " Projet terminé",
                                  icon: Icons.done_all_outlined,
                                  onPressed: () =>
                                      {showMyDialog(context, title!)},
                                ))
                            : const SizedBox()),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
