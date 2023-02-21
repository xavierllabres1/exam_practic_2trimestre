// Aquest seria el provider per interactuar amb la BBDD (a través de DBProvider)
// i els Widgets

import 'package:exam_practic/providers/providers.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class UsersProvider extends ChangeNotifier {
  //Variables
  List<User> usuaris = []; //////// MODIFICAR VARIABLES
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late User tempUsuari; // Usuari temporal

  //Metodes
  //INSERT
  Future<User> nouUser(User u) async {
    print(u.toString());
    // Recuperar id al insertar-ho en la BD
    // Aquest int és perque l'insert retorna un valor enter (segons API):
    // It returns the internal id of the record (an integer).
    final id = await DBProvider.db.insertUser(u);

    //Afegir id al objecte novaDespesa (d'aquest Scope)
    u.id = id;
    print(id);
    //Afagir objecte a llista (si volem)
    usuaris.add(u);

    //actualitzar provider?
    notifyListeners();

    //Retornar el objecte complet (a partir del valor, tenim tipus i despres: id)
    return u;
  }

  //Carregar Scans
  carregaUsuaris() async {
    // Recuperar els valors de la BD
    final usuaris = await DBProvider.db.getAllUsers();

    //Insertar el resultat a la llista Scans a través del Spread Operator '...'
    this.usuaris = usuaris;

    //Notificar el repintat
    notifyListeners();
  }

  // TODO
  // Esborrar tots els registres
  // esborraTots() async {
  //   //Executar la consulta - res = nombre de registes esborrats
  //   final res = await DBProvider.db.deleteAllDespeses();

  //   // Si retorna registres esborrats
  //   if (res > 0) {
  //     //Esborrar la llista
  //     this.despeses = [];

  //     //Notificar el repintat
  //     notifyListeners();
  //   }
  // }

  // TODO
  // Esborrar un registre // Pendent de revisar
  esborraPerId(int id) async {
    // Executar la consulta
    final res = await DBProvider.db.deleteUser(id);

    carregaUsuaris();
    //Notificar el repintat
    //notifyListeners();
  }
}
