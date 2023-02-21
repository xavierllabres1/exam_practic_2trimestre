import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../ui/ui.dart';

class PlusScreen extends StatelessWidget {
  PlusScreen({super.key});

  //key form
  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Afegir"),
      ),
      body: _userContent(),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (usersProvider.formKey.currentState!.validate()) {
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("processant")),
            );

            // CREAR
            usersProvider.nouUser(usersProvider.tempUsuari);
            Navigator.of(context).pop();
          }
        },
        child: const Text('Submit'),
      ),
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

class _userContent extends StatelessWidget {
  const _userContent({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    final u = usersProvider.tempUsuari; // Usuari temporal
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: usersProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nom', labelText: 'Nom:'),
              onChanged: (value) => u.name = value,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Falta valor';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'eMail', labelText: 'eMail:'),
              onChanged: (value) => u.email = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Falta valor';
                }
                return null;
              },
              // inputFormatters: [
              //   FilteringTextInputFormatter.allow(
              //       RegExp(r'^([1-zA-Z0-1@.\s]{1,5})$')),
              // ],
            ),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Adressa', labelText: 'Adressa:'),
              onChanged: (value) => u.address = value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Falta valor';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Telefon', labelText: 'Telefon'),
              onChanged: (value) => u.phone = value,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Falta valor';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'Foto', labelText: 'Foto'),
              onChanged: (value) => u.photo = value,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Falta valor';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
