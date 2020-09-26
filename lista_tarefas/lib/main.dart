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
  //Iremos sobrescrever um método que é chamado sempre
  //quando inicializamos o estado da nossa tela, do nosso
  //widget:
  @override 
  void initState() {
    //Primeiro devemos inicializar o estado da superclasse:
    super.initState();

    //Agora iremos ler os dados do nosso arquivo data.json
    //para carregar a todo list sempre que o app for 
    //aberto. Mas sabemos que o readData é assíncrono
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  //lista para armazenar tarefas:
  // List _toDoList = ["Daniel", "Marcos", "svcdf", "svdfdb", "sgsbfdb"];
  final _toDoController = TextEditingController();
  
  //Além de removermos o item, queremos que apareça uma 
  //snackbar abaixo em que há uma opção para desfazer, e o item
  //que fora deletado anteriormente volta a aparecer.
  List _toDoList = [];
  //Então faremos um map para o último item removido:
  Map<String, dynamic> _lastRemoved;
  // Posição do último item que foi removido, pois o item que
  //foi deletado irá voltar para a posição que estava caso o
  //usuário clique em desfazer.
  int _lastRemovedPos;

  void _addToDo() {
    // Quando lidamos com JSON, normalmente usaremos um
    //map de STRING e dynamic.
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo['title'] = _toDoController.text;
      _toDoController.text = "";
      newToDo['ok'] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  Future<Null> _refresh() async {
    // Essa função irá esperar 1 segundo para somente após 
    //executar
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      //A ordenação será feita com o método sort do dart em que
      //passamos uma função de comparação como parâmetro. Essa 
      //função precisa de 2 argumentos.
      _toDoList.sort((a, b) {
        // Se a > b precisamos retornar 1. Se a = b 
        //retornamos 0 e se a < que b retornamos -1. Essa função
        //será chamada o tempo todo passando 2 itens para informar
        //qual deles é maior. Logo os itens não concluídos devem
        //ser maior que os concluídos:
        if (a['ok'] && !b['ok']) return 1;
        else if (!a['ok'] && b['ok']) return -1;
        else return 0;
        //Se o elemento "a" for true e o "b" não, retornamos 1, o qual manda o "a" para o final da lista;
        //Se o elemento "a" for false e o "b" não, retornamos -1, o qual manda o "a" para o começo da lista;
        //Se ambos forem igual retornamos 0 para indicar que não há relevância.
      });
      
      _saveData();
    });

    return null;
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
            // Por fim queremos fazer o efeito de quando arrastarmos a lista
            //das tarefas para baixo ela colocar em ordem a lista: primeiro
            //os não concluídos e deixar os concluídos pro fim.
            //Para fazer isso iremos por o ListView.builder
            //como filho do widget RefreshIndicator.
            child: RefreshIndicator(
              onRefresh: _refresh,
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
                itemBuilder: buildItem
              ),
            )
          )
        ]
      )
    );
  }

  //Não precisamos definir os tipos dos parâmetros context e
  //index pois estão sendo chamados pelo método build que está
  //também dentro da mesma classe. Mas podemos definí-los se 
  //quisermos também:
  Widget buildItem(BuildContext context, int index) {
    //Dismissible é um widget que permite que o 
    //usuário o arraste, e é o item que precisamos para
    //fazer com que o usuário possa arrastar cada item
    //de forma a deletá-lo.
    return Dismissible(
      // Como nossa lista terá vários elementos, é preciso
      //passar uma key, um identificador de cada elemento.
      //No caso passaremos para pegar os milisegundos do 
      //momento em que ocorre a gravação.
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      // Background é a cor e o widget que será mostrado
      //enquanto o item vai sendo arrastado.
      background: Container(
        color: Colors.red,
        // E queremos que no lugar do ícone do secundary
        //apareça um ícone de lixeira mostrando que o
        //item será deletado, então iremos adicionar como
        //child um align para que dentro dele tenha o ícone
        //da lixeira, alinhado a esquerda.
        child: Align(
          //Para o alignment passamos 2 parâmetros: a
          //distância para esquerda e para direita que o
          //item irá ficar. A distância vai de -1 a 1 em X
          //e o mesmo em Y.
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete, color: Colors.white)
        )
      ),
      //Direção que iremos dar o dismissible, queremos da
      //esquerda para direita, então startToEnd
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
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
            _saveData();
          });
        }
      ),
      // Sempre que arrastarmos um item será chamado a função
      //onDismissed, que requer 1 parâmetro: a direção, que nesse
      //caso será sempre startToEnd.
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          
          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved['title']}\" removida!"),
            action: SnackBarAction(label: "Desfazer", 
              onPressed: () {
                setState(() {
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              }
            ),
            duration: Duration(seconds: 2)
          );

          Scaffold.of(context).showSnackBar(snack);

        });
      }
    );
  }

/*
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
          _saveData();
        });
      }
    );
*/

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