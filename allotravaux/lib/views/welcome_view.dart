import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Text(
                "Bienvenue",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const Text(
                "sur",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const Text(
                "l'application",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.house, size: 150,),
              const Text(
                "Allo' Travaux",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 60, bottom: 60),
                child: Text(
                  "Cette application nécessite la création d’un compte pour prendre contact avec les artisants.",
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.infinity, 40)),
                onPressed:() {
                  
                },
                child: const Text(
                  "Compris !",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
