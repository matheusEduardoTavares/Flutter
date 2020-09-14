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
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
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

  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _clearAll(){
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty){
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real/dolar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty){
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty){
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

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
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                      Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                      buildTextField("Reais", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField("Dólares", "US\$", dolarController, _dolarChanged),
                      Divider(),
                      buildTextField("Euros", "€", euroController, _euroChanged),
                    ]
                  )
                );
              }
          }
        }
      )
    );
  }
}

//É extremamente importante usarmos funções para gerar
//widgets afim de não ficarmos repetindo widgets que 
//são praticamente iguais em várias partes do código.
Widget buildTextField(String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix
    ),
    style: TextStyle(
      color: Colors.amber, fontSize: 25.0
    ),
    onChanged: f,
    // keyboardType: TextInputType.number
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}