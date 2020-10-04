import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _search;

  int _offset = 0;

  Future<Map> _getGifs() async {
    http.Response response;

    if(_search == null)
      response = await http.get("https://api.giphy.com/v1/gifs/trending?api_key=NqbVHGIPsevR7aNbRB89SAsjxznqVvp8&limit=20&rating=g");
    else 
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=NqbVHGIPsevR7aNbRB89SAsjxznqVvp8&q=$_search&limit=20&offset=$_offset&rating=g&lang=en");

    return json.decode(response.body);
  }

  @override 
  void initState(){
    super.initState();

    _getGifs()
    .then((map) {
      print(map);
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        // O Image.network pega uma imagem da 
        //internet.
        title: Image.network("https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif"),
        centerTitle: true
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Pesquise Aqui",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder()
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
              textAlign: TextAlign.center
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: _getGifs(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Container(
                      width: 200.0,
                      height: 200.0,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        // O AlwaysStoppedAnimation irá indicar que 
                        //estamos colocando uma cor no indicator e que
                        //essa cor não irá mudar, ou seja, a cor não
                        //vai mudar, a animação vai estar parada, sendo
                        //do tipo Color com cor branca.
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        //Largura do círculo que ficará girando:
                        strokeWidth: 5.0
                      )
                    );
                  default:
                    if (snapshot.hasError) return Container();
                    else _createGifTable(context, snapshot);
                }
              }
            ),
          )
        ],
      )
    );
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    
  }
}