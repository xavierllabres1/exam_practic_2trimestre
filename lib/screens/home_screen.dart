import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuarisProvider = Provider.of<UsersProvider>(context);
    usuarisProvider.carregaUsuaris();

    return Scaffold(
      appBar: AppBar(
        title: Text("Inici"),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       despesaProvider.esborraTots();
        //     },
        //     icon: Icon(Icons.delete),
        //   )
        // ],
      ),
      body: _contingutHome(usuarisProvider),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          usuarisProvider.tempUsuari =
              User(name: "", email: "", phone: "", photo: "", address: "");

          Navigator.of(context).pushNamed('plus');
        },
      ),
    );
  }

  Widget _contingutHome(UsersProvider userProvider) {
    if (userProvider.usuaris.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: userProvider.usuaris.length,
        itemBuilder: (context, index) {
          // return Dismissible(
          //   key: UniqueKey(),
          //   background: Container(
          //     alignment: AlignmentDirectional.centerEnd,
          //     color: Colors.red,
          //     child: Padding(
          //       padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          //       child: Icon(Icons.delete, color: Colors.red),
          //     ),
          //   ),
          //   child: GestureDetector(
          //     child: UserCard(usuari: userProvider.usuaris[index]),
          //     onTap: () {
          //       // userService.tempUser = usuaris[index].copy();
          //       // Navigator.of(context).pushNamed('detail');
          //     },
          //   ),
          //   onDismissed: (direction) {
          //     if (userProvider.usuaris.length < 2) {
          //       userProvider.carregaUsuaris();
          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //           content: Text('No es pot esborrar tots els elements!')));
          //     } else {
          //       userProvider.esborraPerId(userProvider.usuaris[index].id!);
          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //           content:
          //               Text('${userProvider.usuaris[index].name} esborrat')));
          //     }
          //   },
          // );

          return ListTile(
            leading: Icon(Icons.account_box),
            title: Text(userProvider.usuaris[index].name),
            subtitle: Text(userProvider.usuaris[index].email),
            trailing: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    'show',
                    arguments: userProvider.usuaris[index],
                  );

                  //Navigator.of(context).pushNamed('show');
                },
                child: Icon(Icons.remove_red_eye)),
          );
        },
      );
    }
  }
}
