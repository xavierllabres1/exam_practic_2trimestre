import 'package:flutter/material.dart';

// Carregar imatge amb control d'errors
Image cargarImagenURL(String url) {
  return Image.network(
    url,
    height: 200,
    errorBuilder:
        (BuildContext context, Object exception, StackTrace? stackTrace) {
      return Image.asset(
        'assets/badphoto.png',
        height: 300,
      );
    },
  );
}
