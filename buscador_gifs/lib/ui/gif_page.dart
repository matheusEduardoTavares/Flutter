import 'package:flutter/material.dart';

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
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"])
      )
    );
  }
}