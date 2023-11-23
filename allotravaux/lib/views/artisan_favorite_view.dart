import 'dart:async';

import 'package:allotravaux/assets/my_flutter_app_icons.dart';
import 'package:allotravaux/resources/style.dart';
import 'package:allotravaux/store/artisan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/background_decoration.dart';

class ArtisanFavoriteView extends StatefulWidget {
  final Artisan artisan;
  //String? projectId;

  const ArtisanFavoriteView({
    super.key,
    required this.artisan,
    /*this.projectId*/
  });

  @override
  State<ArtisanFavoriteView> createState() => _ArtisanFavoriteViewState();
}

class _ArtisanFavoriteViewState extends State<ArtisanFavoriteView> {
  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 25),
                  child: Text('Voulez-vous prendre contact avec cet artisan ?'),
                ),
                Text(
                    'Un message récapitulaif de votre projet lui sera directement envoyé pour démarrer cette conversation.'),
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
          ],
        );
      },
    );
  }

  bool isLiked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bodyBackgroundHigh,
        elevation: 0,
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          height: double.infinity,
          decoration: bodyBackgroundDecoration,
          child: SingleChildScrollView(
            child: Column(children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  padding: const EdgeInsets.only(right: 60),
                  onPressed: () async {
                    Fluttertoast.showToast(
                        msg: !widget.artisan.isLiked!
                            ? "Cet artisan fait desormais parti de vos favoris"
                            : "Cet artisan a été retiré de vos favoris",
                        fontSize: 18,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.black);
                    var docToUpdate = await FirebaseFirestore.instance
                        .collection("Artisans")
                        .where("id", isEqualTo: widget.artisan.id)
                        .get();
                    await FirebaseFirestore.instance
                        .collection("Artisans")
                        .doc(docToUpdate.docs.first.id)
                        .update({"isLiked": !widget.artisan.isLiked!});
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: Icon(
                    isLiked ? MyFlutterApp.heart : MyFlutterApp.heart_empty,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: widget.artisan.image == null
                            ? const NetworkImage(
                                "https://www.woolha.com/media/2020/03/eevee.png")
                            : NetworkImage(widget.artisan.image!),
                        radius: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                              "${widget.artisan.firstName} ${widget.artisan.lastName}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.left),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              MyFlutterApp.tools,
                              color: primaryLightButton,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(widget.artisan.job,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(widget.artisan.description ?? "",
                            style: TextStyle(
                                color: primaryLightButton, fontSize: 15),
                            textAlign: TextAlign.left),
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
                      const SizedBox(
                        width: double.infinity,
                        child: Text("Adresse professionnelle :",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.left),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(widget.artisan.address ?? "",
                            style: TextStyle(
                                color: primaryLightButton, fontSize: 15),
                            textAlign: TextAlign.left),
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
                          Text(
                            widget.artisan.firstName.toString(),
                            style: TextStyle(
                                color: primaryLightButton, fontSize: 15),
                          ),
                          Text(
                            " a participé à ",
                            style: TextStyle(
                                color: primaryLightButton, fontSize: 15),
                          ),
                          Text(
                            widget.artisan.projectsNb.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          Text(
                            " projets",
                            style: TextStyle(
                                color: primaryLightButton, fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              "Il a obtenu ",
                              style: TextStyle(
                                  color: primaryLightButton, fontSize: 15),
                            ),
                            Text(
                              widget.artisan.likesNb.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                MyFlutterApp.heart,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ]),
          )),
    );
  }
}
