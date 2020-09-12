import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:async/async.dart';
// Importanto dart:convert temos acesso ao json
//e o método decode desse json transforma uma
//STRING em um map.
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=25603c00";

void main() async {

  http.Response response = await http.get(request);
  // print(response.body);
  //print(json.decode(response.body));

  //Acessando apenas os currencies que estão
  //dentro de results:
  //print(json.decode(response.body)['results']['currencies']);
  
  //acessando apenas o que se refere a moeda
  //dólar:
  print(json.decode(response.body)['results']['currencies']['USD']);

  runApp(MaterialApp(
    title: 'Title',
    home: Container()
  ));
}

