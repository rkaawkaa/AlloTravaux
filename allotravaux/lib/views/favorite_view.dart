import 'package:allotravaux/resources/style.dart';
import 'package:allotravaux/store/artisan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/artisan_card_component.dart';
import '../components/navigation_bar_component.dart';
import '../resources/background_decoration.dart';
import 'artisan_favorite_view.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
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
    return Scaffold(
      body: Container(
        decoration: bodyBackgroundDecoration,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 55, bottom: 60),
                  child: const Text("Favoris",
                      style: TextStyle(color: Colors.white, fontSize: 30))),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RichText(
                      text: TextSpan(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                                text: "Voici la liste de vos artisans favoris"),
                            TextSpan(
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
                    .where('isLiked', isEqualTo: true)
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
                          Navigator.of(context).push(createRoute(
                              ArtisanFavoriteView(artisan: artisan)));
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
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}
