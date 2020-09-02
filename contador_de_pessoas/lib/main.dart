import 'package:flutter/material.dart';

//WIDGETS STATELESS são widgets que não mudam, ficam na tela apenas daquela
//forma. WIDGETS STATEFULL são widgets que tem um estado interno e com isso
//eles podem ser modificados ao longo do tempo.

void main() {
  // runApp(new MaterialApp());
  runApp(MaterialApp(
      title: "Contador de Pessoas",
      // home: Container(color: Colors.white)
      home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

//Essa função build é chamada sempre que queremos modificar alguma coisa
//no nosso layout.
class _HomeState extends State<Home> {
  String _infoText = "Pode Entrar";
  int _people = 0;

  void _changePeople(int delta) {
    //O setState só irá modificar aquilo que foi alterado dentro dele. Isso
    //vai para o build que irá renderizar a tela, somente o que foi mudado.
    setState(() {
      _people += delta;

      if (_people < 0) {
        _infoText = "Mundo invertido!";
      }
      else if (_people <= 10) {
        _infoText = "Pode Entrar!";
      }
      else {
        _infoText = "Lotado";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget> [
          Image.asset(
              "images/restaurant.jpg",
              fit: BoxFit.cover,
              height: 1000.0
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Pessoas: $_people",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            child: Text("+ 1",
                                style: TextStyle(fontSize: 40.0, color: Colors.white)),
                            onPressed: () {
                              // debugPrint("+1");
                              _changePeople(1);
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FlatButton(
                            child: Text("- 1",
                                style: TextStyle(fontSize: 40.0, color: Colors.white)),
                            onPressed: () {
                              //debugPrint("-1");
                              _changePeople(-1);
                            }),
                      )
                    ]
                ),
                Text(_infoText,
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 30.0))
              ])
        ]
    );
  }
}
