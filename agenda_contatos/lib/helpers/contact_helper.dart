//Importaremos primeiramente no pubspec.yaml o 
//sqflite para o nosso projeto, adicionamos
//então no pubspec essa dependência e aqui
//a importamos.
import 'package:sqflite/sqflite.dart';

//Precisamos do nome dos campos no banco de 
//dados para usar tanto na classe Contact
//quanto na ContactHelper, então o definiremos
//aqui no topo. Colocaremos as variáveis como
//final pois seus valores não serão
//modificados.
final String idColumn = "idColumn";
final String nameColumn = "nameColumn";
final String emailColumn = "emailColumn";
final String phoneColumn = "phoneColumn";
final String imgColumn = "imgColumn";

class ContactHelper {

}

// Tabela:
// id   name  email phone img

class Contact {

  //Aqui colocaremos em forma de atributos todos
  //os campos referentes a tabela de contatos.
  int id;
  String name;
  String email;
  String phone;
  String img;
  //Não conseguimos armazenar diretamente uma 
  //imagem no banco de dados então 
  //armazenaremos o local que a imagem foi
  //armazenada em nosso dispositivo.

  //Construtor:
  //Esse construtor pega o map e constrói um
  //contato.
  Contact.fromMap(Map map) {
    //Quando formos armazenar o contato no banco
    //de dados, iremos armazenar em forma de mapa.
    id = map[idColumn];
    name = map[nameColumn];
    email = map[emailColumn];
    phone = map[phoneColumn];
    img = map[imgColumn];
    //Aqui preenchemos os atributos da classe Contact
    //com seus valores correspondentes que virão em
    //formato de map.
  }

  //Esse método gera um map para nós com base nos 
  //dados do contato.
  Map toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imgColumn: img
      //Aqui criamos o map com os valores armazenados
      //no atributo da classe Contact. O ID não é 
      //necessário pois é o banco quem irá gerar os 
      //ID's para nós.
    };
    //Faremos que o id pode ser nulo ou não. Caso seja
    //passado id é aquele id que queremos armazenar.
    //Caso não seja passado fazemos com que o banco crie
    //o ID para nós.
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  //Para podermos ler os dados do contato de uma 
  //forma eficiente podemos sobrescrever o seu
  //método toString e printar o que quisermos
  //no lugar.
  @override 
  String toString() {
    return "Contact(id: $id, name: $name, email: $email, phone: $phone, img: $img)";
  }

}