import 'package:allotravaux/assets/my_flutter_app_icons.dart';
import 'package:allotravaux/resources/style.dart';
import 'package:flutter/material.dart';

class ArtisanCardComponent extends StatefulWidget {
  final String picture;
  final String name;
  final String job;
  final String nbStars;

  const ArtisanCardComponent(
      {super.key,
      required this.picture,
      required this.name,
      required this.job,
      required this.nbStars});

  @override
  State<ArtisanCardComponent> createState() => _ArtisanCardComponentState();
}

class _ArtisanCardComponentState extends State<ArtisanCardComponent> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
          elevation: 10,
          color: secondaryLightButton,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.picture),
                  radius: 35,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 175,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 8),
                      child: Text(
                        widget.name,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 175,
                    child: Text(
                      widget.job,
                      style: const TextStyle(fontSize: 15),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: 175,
                    child: Padding(
                      padding: const EdgeInsets.only(top : 5),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Text(
                              "Popularité : ",
                              textAlign: TextAlign.left
                            ),
                          ),
                          const Icon(
                            MyFlutterApp.heart,
                            color: Colors.red,
                            size: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(widget.nbStars),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ),
    );
  }
}
