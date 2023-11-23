import 'package:flutter/material.dart';

class ConnectionView extends StatelessWidget {
  const ConnectionView({super.key});

  @override
  Widget build(BuildContext context) {

    bool isChecked = false;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Icon(Icons.house, size: 150,),
              const Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: Text(
                  "Allo' Travaux",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Adresse e-mail',
                ),
              ),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Mot de passe',
                ),
              ),
              const Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(
                    fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.infinity, 40)),
                onPressed:() {},
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: const StadiumBorder(),
                    minimumSize: const Size(double.infinity, 40)),
                onPressed:() {},
                child: const Text(
                  "Se connecter",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    onChanged: (bool? value) {
                    },
                  ),
                  const Text(
                  "Rester connecté",
                  style: TextStyle(color: Colors.black),
                ),
                const Text(
                  "Créer un compte",
                  style: TextStyle(
                    fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
