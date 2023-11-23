import 'package:allotravaux/components/message_component.dart';
import 'package:allotravaux/resources/style.dart';
import 'package:allotravaux/views/all_conversations_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';
import '../components/navigation_bar_component.dart';
import '../resources/background_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationView extends StatelessWidget {

  final String artisanFirstName;
  final String artisanLastName;
  final String artisanImage;
  final String projectId;
  final String artisanId;

  ConversationView(
  {
    super.key, 
    required this.artisanFirstName, 
    required this.artisanLastName, 
    required this.artisanImage, 
    required this.projectId, 
    required this.artisanId
  });

  late String mes;
  var msgController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    //print(artisanImage);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bodyBackgroundHigh,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () =>
                Navigator.of(context).push(createRoute(const AllConversationsView()))),
        title: Text(
          "$artisanFirstName  $artisanLastName",
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
        ),
        centerTitle: true,
      ),
      body: Container(
          decoration: bodyBackgroundDecoration,
          child: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Messages')
                      .orderBy('date', descending: false)
                      .snapshots(),
                  builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot message = snapshot.data.docs[index];

                        if (message.get('projectId') != projectId) {
                          return const Text("", style: TextStyle(fontSize: 0));
                        }
                        if (message.get('isMe')) {
                          return MessageComponent(index: index, document: message);
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, bottom: 20),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(artisanImage),
                                  radius: 30,
                                ),
                              ),
                              MessageComponent(index: index, document: message)
                            ],
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: msgController,
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
                          hintText: 'Entrez votre message',
                        ),
                        onChanged: (text) {
                          mes = text;
                        }
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: const StadiumBorder(),
                      ),
                    onPressed: () async {
                      if (msgController.text.isEmpty) {
                         Fluttertoast.showToast(
                          msg: "Vous voulez envoyer un message vide.",
                          fontSize: 18,
                          gravity: ToastGravity.TOP,
                          backgroundColor: Colors.black87,
                          textColor: Colors.black);
                      } else {
                        msgController.clear();
                        FirebaseFirestore.instance.collection('Messages').add({
                          'id': const Uuid().v4(),
                          'projectId': projectId,
                          'artisanId': artisanId,
                          'text': mes,
                          'date': DateTime.now()
                            .subtract(const Duration(minutes: 1))
                            .toString(),
                          'isMe': true
                        });
                      }
                    }, 
                  child: const Icon(Icons.send))
                ],
              ),
            ],
          )),
    );
  }
}
