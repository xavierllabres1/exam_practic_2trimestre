import 'package:shared_preferences/shared_preferences.dart';

class Credencials {
  static late SharedPreferences _credencials;

  // Variables a guardar/recuperar
  static String _correu = '';
  static String _pass = '';
  static bool _check = false;

  // Ja que el constructor no pot retornar un "Future" generam el mètode per
  // per recuperar
  static Future init() async {
    _credencials = await SharedPreferences.getInstance();
  }

  // Getters i Setters
  static String get correu {
    return _credencials.getString('correu') ?? _correu;
  }

  static set correu(String value) {
    _correu = value; //Assigam a la variable privada
    _credencials.setString('correu', value); //Assignam a les preferencies
  }

  static String get pass {
    return _credencials.getString('pass') ?? _pass;
  }

  static set pass(String value) {
    _pass = value; //Assigam a la variable privada
    _credencials.setString('pass', value); //Assignam a les preferencies
  }

  static bool get isCheck {
    return _credencials.getBool('check') ?? _check;
  }

  static set isCheck(bool value) {
    _check = value;
    _credencials.setBool('check', value);
  }
}
