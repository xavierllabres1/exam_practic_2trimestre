// Tot i estar al directori Providers, aquesta classe actuaria com la classe
// que  el provider ScanListProvider empraria per accedir a la BBDD

// Aquesta clase no "extends ChangeNotifier"

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/models.dart';

class DBProvider {
  // BBDD (local a aquest app)
  static Database? _database;

  // Instancia de la propia classe
  static final DBProvider db = DBProvider._();

  // Constructor tipus privat
  DBProvider._();

  //Getter i Setters

  //Geter, és asyncron i per això retorna un Future
  Future<Database> get database async {
    // comprovam si existeix la bbdd.
    // Si no existeix, la cream amb l'initDB
    if (_database == null) return _database = await initDB();

    // Es retorna, ja sigui nova o abans creada
    return _database!;
  }

  //Metode initDB. Async i per això retorna future
  Future<Database> initDB() async {
    // Obtenir el path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //Path (Ruta de la DB)
    final path = join(
        documentsDirectory.path, 'database.db'); ///////// DEFINIR NOM DATABASE

    // Crear la BBDD
    // a traves dels parametres definim com es comportara
    // El que realitzarà al crearse (on create)
    // El que realitzarà les altres vegades per exemple.
    return await openDatabase(
      path,
      version: 1, //Versió de la bbdd que hem creat, per si volem fer instancies
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        ///////// SETENCIA CREATE de la DATABASE
        await db.execute('''
          CREATE TABLE Users(
            id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            address TEXT,
            phone TEXT,
            photo TEXT
          )
        ''');
      },
    );
  }

  // Operacions CRUD //
  // Operacions amb la DB (totes son sempre asnycrones)

  // // INSERT (RAW. similar a un 'statement' de JAVA. Sentencia SQL integra)        ///////// INSERT RAW (Depen del Objecte)
  // Future<int> insertRawDespesa(Despesa novaDespesa) async {
  //   //Variables
  //   final id = novaDespesa.id;
  //   final titol = novaDespesa.titol;
  //   final quantitat = novaDespesa.quantitat;

  //   // Objecte db que es recupera el database (get)
  //   // Aquest db només es visible dins aquest scope
  //   final db = await database;

  //   // Consulta                                                                   ///////// INSERT RAW (QUERY SQL)
  //   final res = await db.rawInsert('''
  //     INSERT INTO Despeses (titol, quantitat)
  //       VALUES ($titol, $quantitat)
  //     ''');

  //   // Resultat
  //   return res;
  //   // Retorna un enter (Doc de la API)
  //   // insert is for inserting data into a table.
  //   // It returns the internal id of the record (an integer).
  // }

  // INSERT (no RAW. Similar a un 'preparedStatement' de JAVA. No sentencia SQL)  ///////// INSERT (Depen del Objecte)
  Future<int> insertUser(User nouUser) async {
    // objecte db (el get de database)
    final db = await database;

    // Consulta
    final res = await db.insert(
        'Users', nouUser.toMap()); ///////// INSERT (Identificar Objecte)

    // Resultat
    return res;
    // Retorna un enter (Doc de la API)
    // insert is for inserting data into a table.
    // It returns the internal id of the record (an integer).
  }

  // SELECT (*)                                                                   ///////// SELECT * (Depen del Objecte)
  Future<List<User>> getAllUsers() async {
    // objecte db (el get de database)
    final db = await database;

    // Consulta
    final res = await db.query('Users'); ///////// Identificar nom Taula

    // Resultat
    // ? i : son operadors ternaris
    // Per cada entrada (e) realitzam el "fromMap"(definit al model) -> a Lista
    //  ja que es retorna una List
    // Si la consulta no retorna cap resultat, es retorna una llista buida
    return res.isNotEmpty
        ? res.map((e) => User.fromMap(e)).toList()
        : []; ///////// SELECT * (Depen del Objecte)
  }

  // SELECT (WHERE id) (similar preparedStatement JAVA)                           ///////// SELECT WHERE (Depen del Objecte)
  Future<User?> getUserById(int id) async {
    // objecte db (el get de database)
    final db = await database;

    // Consulta                                                                   ///////// Identificar nom Taula + WHERE
    final res = await db.query(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Resultat (exemple sense ternaris)                                          ///////// SELECT WHERE (Depen del Objecte)
    if (res.isNotEmpty) {
      // Si no esta buit, retornam el primer
      return User.fromMap(res.first);
    } else {
      // Buit retornam null
      return null;
    }
  }

  // UPDATE (WHERE id) (similar preparedStatement JAVA)                           ///////// UPDATE WHERE (Depen del Objecte)
  Future<int> updateUser(User nouUser) async {
    // Recuperar DB
    final db = await database;

    // Consulta                                                                   ///////// UPDATE WHERE (Condició)
    final res = db.update(
      'Users',
      nouUser.toMap(),
      where: 'id = ?',
      whereArgs: [nouUser.id],
    );

    // Resultat
    return res; // això no se que torna exactament. Comprovar amb el funcionament
  }

  // DELETE (*) (RAW - sentencia SQL)                                             ///////// DELETE RAW *
  Future<int> deleteAllUsers() async {
    // Recuperar DB
    final db = await database;

    // Consulta                                                                   ///////// DELETE RAW * (Consulta SQL)
    final res = db.rawDelete('''
      DELETE FROM Users
      ''');

    // Resultat
    return res;
  }

  // DELETE (WHERE id) (similar preparedStatement JAVA)                           ///////// DELETE WHERE
  Future<int> deleteUser(int id) async {
    // Recuperar DB
    final db = await database;

    // Consulta                                                                   ///////// DELETE WHERE (Condicio)
    final res = db.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );

    // Resultat
    return res;
  }
}
