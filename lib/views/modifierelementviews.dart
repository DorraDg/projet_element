import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/type_elements.dart';
import 'package:flutter_application_1/services/sqldatabase.dart';


class ModifierElementViews extends StatefulWidget {
  final int? elementId;
  const ModifierElementViews({super.key, this.elementId});

  @override
  State<ModifierElementViews> createState() => _ModifierElementViewsState();
}
class _ModifierElementViewsState extends State<ModifierElementViews> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadElementData();
  }
  Future<void> _loadElementData() async {
    if (widget.elementId != null) {
      final element = await CruddataBase().getElementWithId(widget.elementId!);
      if (element != null) {
        setState(() {
          nomController.text = element.nom;
          descriptionController.text = element.description;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier les elements'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 76, 175, 167),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
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
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () async {
                final nom = nomController.text;
                final description = descriptionController.text;
                if (nom.isNotEmpty && description.isNotEmpty) {
                  final element = TypeElement(id: widget.elementId, nom: nom, description: description);
                  await CruddataBase().updateElement(element);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Element mis à jour avec succès')));
                  Navigator.pop(context, true);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez remplir tous les champs !')));
                }
              },
              child: const Text("Mettre à jour"),
            )
          ],
        ),
      ),
    );
  }
}