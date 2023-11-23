import 'package:flutter/material.dart';
import 'package:allotravaux/resources/style.dart';

class TypeArtisanCardComponent extends StatelessWidget {
  final String? name;
  final dynamic data;

  const TypeArtisanCardComponent(
      {super.key,
      required this.name,
      this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: InkWell(
            child: Card(
              color: secondaryLightButton,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                      title: Text(name!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
