import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import '../models/models.dart';
import '../providers/users_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladors
  TextEditingController _userTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  // Shared Preferences
  bool localCheck = Credencials.isCheck;

  @override
  Widget build(BuildContext context) {
    // final despesaProvider = Provider.of<DespesesProvider>(context);
    if (localCheck) {
      if (Credencials.correu != null) {
        _userTextController.text = Credencials.correu;
        _passwordTextController.text = Credencials.pass;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: _buildBoxDecoration(),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                TextField(
                  controller: _userTextController,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.person),
                    labelText: "Usuari",
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _passwordTextController,
                  decoration: InputDecoration(
                    prefix: Icon(Icons.password),
                    labelText: "Password",
                  ),
                ),
                SwitchListTile(
                  value: Credencials.isCheck, //getter* (ja que no duu () )
                  title: const Text(
                    'Guardar Credencials',
                  ),
                  onChanged: (value) {
                    Credencials.isCheck = value;

                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.login),
          onPressed: () {
            if (Credencials.isCheck) {
              Credencials.correu = _userTextController.text;
              Credencials.pass = _passwordTextController.text;
            }

            // Es desactiva el control d'usuari
            // if (_userTextController.text == "usuari" &&
            //     _passwordTextController.text == "pass") {
            Navigator.of(context).pushNamed('home');
            print("login");
          }),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: Offset(0, 5),
              blurRadius: 5),
        ],
      );
}
