import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/data.dart';
import 'providers/providers.dart';
import 'routes/routes.dart';

void main() async {
  // Main async per poder carregar Shared Preferences

  // Ens permet recollir Shared Preferences Abans de Carregar
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega Shared Preferences - Credencials
  await Credencials.init();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UsersProvider())],
      child: MyApp(),
    ),
  );
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examen Template',
      initialRoute: 'login', // Start on signin for production
      routes: getRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
