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
      // O FutureBuilder precisa de um builder,
      //O atributo future é o que ele deve esperar,
      //Iremos mostrar carregando dados na tela.
      //O atributo builder passamos para ele uma
      //função anônima que tem 2 parâmetros: 
      //o contexto e o snapshot que é uma cópia
      //uma fotografia momentanea dos dados que
      //virão do que está no future.
      body: FutureBuilder<Map>(
        future: getData(),
        // Se o connectionState desse segundo
        //parâmetro do builder estiver como
        //none ou como waiting devemos mostrar
        //o texto pois os dados ainda não 
        //foram carregados. Do contrário já
        //podemos trabalhar com esses dados 
        //na tela.
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: Text("Carregando Dados...",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0
                    ),
                    textAlign: TextAlign.center
                  )
                );
            default:
              if (snapshot.hasError){
                return Center(
                  child: Text("Erro ao Carregar Dados :(",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0
                    ),
                    textAlign: TextAlign.center
                  )
                );
              }
              else {
                return Container(
                  color: Colors.green
                );
              }
          }
        }
      )
    );
  }
}