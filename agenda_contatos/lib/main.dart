import 'package:flutter/material.dart';
import 'package:agenda_contatos/ui/home_page.dart';

void main(){
  runApp(MaterialApp(
    title: 'Agenda de contatos',
    home: HomePage()
  ));
}

//Agora iremos armazenar os dados não em um JSON,
//e sim em tabelas, usando o sqflite. Criaremos
//uma pasta chamada helpers onde estarão as 
//classes que ajudarão o nosso código.