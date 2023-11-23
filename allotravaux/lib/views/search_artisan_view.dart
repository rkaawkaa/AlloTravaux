import 'package:allotravaux/resources/style.dart';
import 'package:allotravaux/store/artisan.dart';
import 'package:allotravaux/store/project.dart';
import 'package:allotravaux/views/recap_project_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/artisan_card_component.dart';
import '../components/navigation_bar_component.dart';
import '../resources/background_decoration.dart';
import 'artisan_view.dart';

class SearchArtisanView extends StatefulWidget {
  final Project project;
  const SearchArtisanView({super.key, required this.project});

  @override
  State<SearchArtisanView> createState() => _SearchArtisanViewState();
}

class _SearchArtisanViewState extends State<SearchArtisanView> {
  var listCardState = listCard;

  static final listCard = [];

  bool visible = false;
  bool plumberIsSelected = false;
  bool carpenterIsSelected = false;
  bool tilerIsSelected = false;
  bool painterIsSelected = false;

  var data = listCard;

  @override
  initState() {
    super.initState();
  }

  String addSuffix(String input) => "${input.toLowerCase()}s";

  @override
  Widget build(BuildContext context) {
    var typeArtisan = widget.project.typeArtisan;
    var typeArtisanPlural = addSuffix(typeArtisan);
    var title = widget.project.title;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bodyBackgroundHigh,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () =>
                Navigator.of(context).push(createRoute(RecapProjectView(project: widget.project)))),
        title: const Text(
          "Trouver un artisan",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: bodyBackgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: 23,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                            children: <TextSpan>[
                              const TextSpan(text: "Pour votre projet : "),
                              TextSpan(
                                  text: title,
                                  style: TextStyle(
                                      color: primaryLightButton,
                                      fontWeight: FontWeight.bold)),
                            ]),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            const TextSpan(text: "Voici la liste des "),
                            TextSpan(
                                text: typeArtisanPlural,
                                style: TextStyle(
                                    color: primaryLightButton,
                                    fontWeight: FontWeight.bold)),
                            const TextSpan(text: " :"),
                          ]),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Artisans')
                    .where('job', isEqualTo: typeArtisan)
                    .snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.docs[index];
                      return InkWell(
                        child: SizedBox(
                          width: double.infinity,
                          child: ArtisanCardComponent(
                            picture: data.get('image'),
                            name: data.get('firstName') +
                                " " +
                                data.get('lastName'),
                            job: data.get('job'),
                            nbStars: data.get('likesNb').toString(),
                          ),
                        ),
                        onTap: () {
                          Artisan artisan = Artisan(
                            id: data.get('id'),
                            firstName: data.get('firstName'),
                            lastName: data.get('lastName'),
                            job: data.get('job'),
                            image: data.get('image'),
                            likesNb: data.get('likesNb'),
                            projectsNb: data.get('projectsNb'),
                            description: data.get('description'),
                            address: data.get('address'),
                            isLiked: data.get('isLiked'),
                          );
                          Navigator.of(context).push(createRoute(ArtisanView(
                              artisan: artisan, project: widget.project)));
                        },
                      );
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
