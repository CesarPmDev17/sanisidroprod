// To parse this JSON data, do
//
//     final museo = museoFromJson(jsonString);

import 'dart:convert';

Museo museoFromJson(String str) => Museo.fromJson(json.decode(str));

String museoToJson(Museo data) => json.encode(data.toJson());

class Museo {
  Museo({
    required this.titulo,
    required this.foto,
    required this.url,
  });

  final String titulo;
  final String foto;
  final String url;

  factory Museo.fromJson(Map<String, dynamic> json) => Museo(
        titulo: json["titulo"],
        foto: json["foto"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "titulo": titulo,
        "foto": foto,
        "url": url,
      };
}
