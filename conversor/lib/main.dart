import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
// Importanto dart:convert temos acesso ao json
//e o método decode desse json transforma uma
//STRING em um map.
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?key=25603c00";

void main() async {
  // http.Response response = await http.get(request);
  // print(response.body);
  //print(json.decode(response.body));

  //Acessando apenas os currencies que estão
  //dentro de results:
  //print(json.decode(response.body)['results']['currencies']);
  //acessando apenas o que se refere a moeda
  //dólar:
  // print(json.decode(response.body)['results']['currencies']['USD']);

  runApp(MaterialApp(
    title: 'Title',
    home: Home()
  ));
}

//Faremos uma função que retornará um map mas
//no futuro:
Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true
      ),
      //O futureBuilder enquanto estiver 
      //obtendo nossos dados podemos fazer
      //com que seja mostrado "carregando dados"
      //E depois que os dados são carregados, 
      //como no caso do método getData.
      body: Text("futureBuilder será implementado na próxima aula")
    );
  }
}