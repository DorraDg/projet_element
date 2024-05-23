import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/type_elements.dart';
import 'package:flutter_application_1/services/sqldatabase.dart';
import 'package:flutter_application_1/views/ajouterelementviews.dart';
import 'package:flutter_application_1/views/modifierelementviews.dart';

class AffichageElementViews extends StatefulWidget {
  const AffichageElementViews ({Key? key}) : super(key: key);

  @override
  _AffichageElementViewsState createState() => _AffichageElementViewsState();
}

class _AffichageElementViewsState extends State<AffichageElementViews> {
  late Future<List<TypeElement>> _future;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _future = CruddataBase().getTypeElement();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Les Elements"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 81, 194, 194),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: FutureBuilder<List<TypeElement>>(
        future: _future,
        builder: (context, AsyncSnapshot<List<TypeElement>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur de connexion"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('Aucun element trouvé'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final element = snapshot.data![index];
                return ListTile(
                  title: Text(element.nom),
                  subtitle: Text(element.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ModifierElementViews(elementId: element.id),
                            ),
                          );
                          if (result != null && result is bool && result) {
                            _refreshData();
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          if (element.id != null) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                      "Voulez-vous vraiment supprimer cet Element ?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await CruddataBase()
                                            .deleteElement(element.id!);
                                        _refreshData(); // Refresh the list after deletion
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                      child: const Text("Supprimer"),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjouterElementViews(),
            ),
          );
          if (result != null && result is bool && result) {
            _refreshData();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}