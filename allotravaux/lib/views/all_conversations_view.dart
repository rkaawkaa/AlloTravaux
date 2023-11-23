import 'package:allotravaux/resources/style.dart';
import 'package:allotravaux/views/conversation_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/navigation_bar_component.dart';
import '../resources/background_decoration.dart';

class AllConversationsView extends StatefulWidget {
  const AllConversationsView({super.key});

  @override
  State<AllConversationsView> createState() => _AllConversationsViewState();
}

class _AllConversationsViewState extends State<AllConversationsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: bodyBackgroundDecoration,
          child: Column(
            children:  [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text('Vos conversations',
                style: TextStyle(color: Colors.white, fontSize: 30)),
              ),
              Expanded(
                child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Conversations')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data.docs[index];
                      return InkWell(
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(data.get('artisanImage')),
                                      radius: 30,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 3, bottom: 8),
                                        child: Text(
                                          data.get('artisanFirstName') + "  " + data.get('artisanLastName'),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20, 
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 175,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 5),
                                          child: Text(
                                            data.get('projectTitle'),
                                            style: TextStyle(
                                              color: primaryLightButton,
                                            ),
                                            textAlign: TextAlign.left
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                                  child: Divider(
                                    color: primaryLightButton,
                                    height: 15,
                                    thickness: 1,
                                    indent: 2,
                                    endIndent: 2,
                                  ),
                              ),
                            ],
                          )
                        ),
                        onTap: () async {

                          var firstName = data.get('artisanFirstName');
                          var lastName = data.get('artisanLastName');

                          //var project = await FirebaseFirestore.instance
                          //  .collection("Projects")
                          //  .where("id", isEqualTo: data.get('projectId'))
                          //  .get();

                          var projectId = data.get('projectId');
                          var artisanId = data.get('artisanId');
                          var artisanImage = data.get('artisanImage');
                          
                          Navigator.of(context)
                              .push(createRoute(ConversationView(artisanFirstName: firstName, artisanLastName: lastName, artisanImage: artisanImage, projectId: projectId, artisanId: artisanId)));
                        },
                      );
                    },
                  );
                },
              )),
            ],
          )),
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}
