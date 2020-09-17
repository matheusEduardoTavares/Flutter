//Precisamos importar o dart:io para ter acesso ao
//File.
import 'dart:io';
import 'package:flutter/material.dart';
// Precisamos do path_provider, ele nos ajuda a ler
//os arquivos do android e do iOS.
import 'package:path_provider/path_provider.dart';
//Para usar o json:
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'lista_tarefas',
    home: Home()
  ));
}

class Home extends StatefulWidget {
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //lista para armazenar tarefas:
  List _toDoList = [];

  @override 
  Widget build(BuildContext context) {
    return Container();
  }

  //Função para salvar os dados:
  Future<File> _saveData() async {
    //Convertemos primeiro a lista em JSON.
    String data = json.encode(_toDoList);
    //Depois pegamos o arquivo:
    final file = await _getFile();
    //Pegamos o arquivo que obtemos e escrevemos
    //nele como uma string através do método
    //writeAsString passando o JSON que queremos
    //armazenar nele.
    return file.writeAsString(data);
  }

  //Recuperar os dados:
  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    }
    catch (e) {
      return null;
    }
  }
}

//Função que retornará o arquivo que será usado
//para salvar:
Future<File> _getFile() async {
  // Agora iremos pegar o diretório onde iremos
  //armazenar as nossas tarefas, onde
  //armazenaremos o JSON. Mas esse local, o
  //path no android e no iOS são diferentes.
  //Em cada um deles o path é diferente, e 
  //tem as questões das permissões também:
  //se iremos permitir ou não que acessemos
  //essa pasta. Portanto isso seria um 
  //pouco chato de fazer, mas o 
  //path_provider irá nos ajudar nisso,
  //através da função getApplicationDocumentsDirectory,
  //uma função que pega o diretório onde podemos
  //armazenar os documentos do APP, mas isso é algo
  //assíncrono, retorna um future por isso usamos
  //o await.
  final directory = await getApplicationDocumentsDirectory();
  //Agora retornamos um File passando como parâmetro 
  //posicional uma string que representa o caminho dele.
  //Basicamente iremos passar o caminho que é provido da
  //constante directory, e este arquivo retornado será
  //o data.json que estará presente dentro deste 
  //diretório.
  return File("${directory.path}/data.json");
  //Sempre que precisamos do arquivo para salvar os
  //dados agora é só chamar essa função _getFile
}