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
      response = await http.get("https://api.giphy.com/v1/gifs/search?api_key=NqbVHGIPsevR7aNbRB89SAsjxznqVvp8&q=$_search&limit=19&offset=$_offset&rating=g&lang=en");

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
              textAlign: TextAlign.center,
              //O onSubmitted é chamado quando o usuário clica
              //no botão de enviar do teclado, demonstrando que
              //o texto já terminou de ser digitado e já pode 
              //ser envido. Seu parâmetro é o texto digitado 
              //no campo antes de clicar para confirmar.
              onSubmitted: (text) {
                //Devido ao setState, o FutureBuilder será 
                //renderizado novamente e assim conseguimos 
                //atualizar a lista.
                setState(() {
                  _search = text;
                  //Aqui devemos resetar o offset se não ele 
                  //não irá mostrar os primeiros itens, pois 
                  //caso pesquisamos uma coisa e depois vamos 
                  //pesquisar outra, será considerado aquele 
                  //offset que estava antes e que pode ter sido
                  //alterado caso o usuário clicou para carregar
                  //mais.
                  _offset = 0;
                });
              },
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
                    else return _createGifTable(context, snapshot);
                }
              }
            ),
          )
        ],
      )
    );
  }

  int _getCount(List data){
    if (_search == null) {
      return data.length;
    }
    else {
      return data.length + 1;
    }
  }

  Widget _createGifTable(BuildContext context, AsyncSnapshot snapshot) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      // O gridDelegate mostra como os itens 
      //serão organizados na nossa tela.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //Quantos itens tem no eixo X:
        crossAxisCount: 2,
        //Espaçamento no eixo X:
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0
      ),
      //Quantidade de itens:
      itemCount: _getCount(snapshot.data["data"]),
      itemBuilder: (context, index) {
        // Aqui iremos retornar uma imagem 
        //sendo que cada widget que é retornado
        //aqui será usado por um índice dos itens.
        //Mas retornaremos um GestureDetector para
        //ser possível detectar quando o usuário
        //clica na imagem.
        //Se não estivermos pesquisando ou se estivermos pesquisando
        //mas o item a ser mostrado não é o último item simplesmente
        //retornamos a imagem do gif. Se for uma pesquisa e for o último
        //item, queremos por um botão para o usuário pesquisar mais,
        //mudando a paginação, por isso nesse caso temos que retornar
        //um ícone para carregar mais, e não uma imagem.
        if (_search == null || index < snapshot.data["data"].length)
          return GestureDetector(
            child: Image.network(
              snapshot.data["data"][index]["images"]["fixed_height"]["url"],
              height: 300.0,
              fit: BoxFit.cover
            ),
          );
        else 
          return Container(
            child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, color: Colors.white, size: 70.0),
                  Text("Carregar mais...", 
                    style: TextStyle(color: Colors.white, fontSize: 22.0)
                  )
                ],
              ),
              onTap: () {
                setState(() {
                  //Aqui pegamos + 19 itens e com o setState o Future
                  //Builder é renderizado novamente.
                  _offset += 19;
                });
              },
            )
          );
      }
    );
  }
}