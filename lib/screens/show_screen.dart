import 'package:exam_practic/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../ui/ui.dart';

class ShowScreen extends StatelessWidget {
  ShowScreen({super.key});

  //key form
  @override
  Widget build(BuildContext context) {
    final usuarisProvider = Provider.of<UsersProvider>(context);

    final u = ModalRoute.of(context)!.settings.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text(u.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: usuarisProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              ListTile(
                title: Text(u.name),
              ),
              ListTile(
                title: Text(u.email),
              ),
              ListTile(
                title: Text(u.address),
              ),
              ListTile(
                title: Text(u.phone),
              ),
              cargarImagenURL(u.photo),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          // if (usersProvider.formKey.currentState!.validate()) {
          //   // If the form is valid, display a snackbar. In the real world,
          //   // you'd often call a server or save the information in a database.
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text("processant")),
          //   );

          // ESBORRAR
          usuarisProvider.esborraPerId(u.id!);
          Navigator.of(context).pop();
          // }
        },
        child: const Text('ESBORRAR'),
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
