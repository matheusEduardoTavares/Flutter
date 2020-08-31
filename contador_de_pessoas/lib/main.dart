import 'package:flutter/material.dart';

void main(){
  // runApp(new MaterialApp());
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      // home: Container(color: Colors.white)
      home: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Pessoas: 0",
                style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold)),
            Text("Pode Entrar!",
                style: TextStyle(color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 30.0
                )
            )
          ]
      )
  ));
}