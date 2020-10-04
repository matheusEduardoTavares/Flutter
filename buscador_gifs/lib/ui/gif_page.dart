import 'package:flutter/material.dart';
import 'package:share/share.dart';

//Em flutter as páginas também são WIDGETS. Essa
//página não é modificável, não tem alteração, 
//logo não precisa ser um widget stateful.

class GifPage extends StatelessWidget {

  final Map _gifData;

  GifPage(this._gifData);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"]),
        backgroundColor: Colors.black,
        // Colocaremos um botão para compartilhar aqui. Para
        //fazer a ação de compartilhamento, colocaremos um
        //plugin do flutter chamado share
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              // Aqui nós compartilhamos o link para o gif. Dessa
              //forma ele já é capaz de compartilhar a imagem com
              //contatos, whatsapp, facebook, email, e etc
              Share.share(_gifData["images"]["fixed_height"]["url"]);
            }
          )
        ]
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"])
      )
    );
  }
}