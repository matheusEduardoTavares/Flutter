import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title: '',
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _pessoas = 0;
  String _text = "Pode Entrar!";

  void _increment(int val) {
    setState(() {
      _pessoas += val;

      if (_pessoas < 0){
        _text = "Mundo alternativo";
      }
      else if (_pessoas > 10) {
        _text = "Lotado!";
      }
      else {
        _text = "Pode Entrar!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget> [
          Image.asset(
              'images/restaurant.jpg',
              fit: BoxFit.cover,
              height: 1000
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Pessoas: $_pessoas', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                      child: Text("+ 1", style: TextStyle(fontSize: 40, color: Colors.white)),
                      onPressed: () => _increment(1)
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: FlatButton(
                      child: Text("-1", style: TextStyle(fontSize: 40, color: Colors.white)),
                      onPressed: () {
                        _increment(-1);
                      }
                    )
                  )
                ]
              ),
              Text("$_text", style: TextStyle(fontSize: 30, color: Colors.white, fontStyle: FontStyle.italic))
            ],
          )
        ]
    );
  }
}