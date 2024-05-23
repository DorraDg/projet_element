class TypeElement {
  int? id;
  String nom;
  String description;
  TypeElement({this.id,  required this.nom,required this.description});
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nom": nom,
      "description": description,
    };
  }

  factory TypeElement.fromMap(Map<String, dynamic> map) {
    return TypeElement(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      );
  }
}
