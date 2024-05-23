import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/type_elements.dart';
import 'package:flutter_application_1/services/sqldatabase.dart';


class AjouterElementViews extends StatelessWidget {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController especeController = TextEditingController();
  AjouterElementViews({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un Element'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 33, 243, 226),
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {},
          icon: const Icon(Icons.search)),
          IconButton(onPressed: () {},
          icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: nomController,
              decoration: const InputDecoration(labelText: "Nom de l\'Element"),
            ),
            TextField(
              controller: especeController,
              decoration: const InputDecoration (labelText: "Description de l\'Element"),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(onPressed: () async {
              final nom = nomController.text;
              final description = especeController.text;
              if (nom.isNotEmpty && description.isNotEmpty) {
                final element = TypeElement(nom: nom, description: description);
                await CruddataBase().insertElement(element);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Element ajouté avec succès')));
                  Navigator.pop(context, true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez saisir les champs !')));
              }
            },
            child: Text("Ajouter un Element"))
          ],
        ),
      ),
    );
  }
}

