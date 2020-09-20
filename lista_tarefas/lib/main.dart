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
  // List _toDoList = ["Daniel", "Marcos", "svcdf", "svdfdb", "sgsbfdb"];
  final _toDoController = TextEditingController();
  
  List _toDoList = [];


  void _addToDo() {
    // Quando lidamos com JSON, normalmente usaremos um
    //map de STRING e dynamic.
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = _toDoController.text;
      _toDoController.text = "";
      newToDo['ok'] = false;
      _toDoList.add(newToDo);
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas!"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true
      ),
      body: Column(
        children: <Widget> [
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
            child: Row(
              children: <Widget> [
                // Sem o expanded irá dar erro pois o 
                //flutter não sabe qual é a largura que
                //o TextField e que o RaisedButton devem
                //ocupar na tela. Com o expanded, significa
                //que quem está dentro dele, no caso o 
                //TextField irá expandir o máximo que der
                //de largura, e o botão irá ocupar o tamanho
                //mínimo necessário, enquanto o TextField
                //ocupará todo tamanho da largura que 
                //restar.
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nova Tarefa",
                      labelStyle: TextStyle(color: Colors.blueAccent)
                    ),
                    controller: _toDoController
                  )
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: _addToDo
                )
              ]
            )
          ),
          Expanded(
            //ListView é um widget que nós podemos
            //fazer uma lista. O builder é um
            //construtor que nos permite construir a
            //lista conforme vamos rodando ela, ou seja,
            //os elementos que estão escondidos em baixo
            //da tela, que não estão aparecendo devido 
            //ao scroll não são renderizados na tela e 
            //não irão consumir recursos até o momento
            //que efetivamente aparecerem na tela.
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              // itemCount é a quantidade de itens que
              //estarão dentro da lista.
              itemCount: _toDoList.length,
              //No itemBuilder colocamos os elementos da
              //lista. Passamos para ela uma função que
              //recebe o contexto e o índice de cada 
              //elemento da lista. E nessa função
              //é retornado o widget que queremos que
              //apareça na tela. Iremos retornar um
              //widget chamado ListTile que seria um 
              //item específico da lista.
              itemBuilder: (context, index) {
                // return ListTile(
                //   title: Text(_toDoList[index])
                // );
                //Como queremos fazer um todo list, onde o usuário
                //marca se dada tarefa foi terminada ou não, é +
                //interessante usarmos no lugar do ListTile o 
                //widget CheckboxListTile que é específico para esse
                //fim:
                return CheckboxListTile(
                  title: Text(_toDoList[index]['title']),
                  //value é se o checkbox está ou não marcado
                  value: _toDoList[index]['ok'],
                  //secondary é um ícone que podemos por para ser 
                  //mostrado antes do title. Podemos passar para
                  //ele um CircleAvatar que é um widget em formato 
                  //de círculo que dependendo se uma tarefa foi feita
                  //estará com um ícone X e se não for feita um ícone
                  //Y:
                  secondary: CircleAvatar(
                    child: Icon(_toDoList[index]['ok'] ?
                      Icons.check : Icons.error
                    )
                  ),
                  onChanged: (c) {
                    setState(() {
                      _toDoList[index]['ok'] = c;
                    });
                  }
                );
              }
            )
          )
        ]
      )
    );
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