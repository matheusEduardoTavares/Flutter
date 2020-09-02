import 'package:flutter/material.dart';

void main(){

}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      Image.asset(
        'image/restaurant.png'
      )
    )
  }
}