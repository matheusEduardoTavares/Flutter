//Importaremos primeiramente no pubspec.yaml o 
//sqflite para o nosso projeto, adicionamos
//então no pubspec essa dependência e aqui
//a importamos.
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Nome da tabela:
final String contactTable = "contactTable";
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

//Essa classe ContactHelper irá conter apenas
//um objeto no código inteiro, ou seja, é 
//uma classe que não poderá ter várias 
//instâncias ao longo do seu código e por
//isso nós iremos utilizar um padrão
//chamado Singleton. É um padrão muito
//interessante quando queremos ter apenas
//um objeto de uma dada classe. 
class ContactHelper {

  //Aqui instanciamos um objeto da
  //classe ContactHelper com o construtor 
  //internal dessa classe. Essa instância
  //será estática e final.
  static final ContactHelper _instance = ContactHelper.internal();

  //Quando declaramos a classe ContactHelper
  //criamos um objeto dela mesmo, o _instance,
  //que chama um construtor interno, ou seja
  //é um construtor que só pode ser chamado 
  //de dentro da classe e de mais nenhum lugar.
  //Para acessar essa instância de qualquer local
  //do código é só fazer: ContactHelper._instance e
  //acessamos essa instância. O factory nos 
  //permite retornar um objeto já existente,
  //de forma que não precisa criar um novo
  //objeto sempre.
  factory ContactHelper() => _instance;

  ContactHelper.internal();

  //Agora vamos declarar uma variável privada
  //do tipo Database de forma que queremos mostrar
  //que apenas o ContactHelper poderá acessar essa
  //variável de banco de dados.
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Contact> saveContact(Contact contact) async {
    //Primeiro acessamos o banco de dados
    Database dbContact = await db;
    //Agora inserimos nessa tabela o contato
    //que queremos, mas primeiro temos que o 
    //transformar em um mapa. Depois de salvar
    //o contato é retornado o ID que foi salvo 
    //o usuário.
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Database> initDb() async {
    //Primeiro pegamos o local onde é armazenado o 
    //banco de dados
    final databasesPath = await getDatabasesPath();
    //Agora pegamos o caminho para o banco de dados
    //e juntamos com o nme do banco, e estamos
    //retornando o caminho disso. Para usar o 
    //método join precisamos importar o package
    //path do dart que já vem por default, então
    //não precisamos colocar nenhuma dependência
    //no pubspec.
    final path = join(databasesPath, "contactsnew.db");

    //Agora abrimos o banco de dados passando primeiro
    //o path, depois a versão do banco de dados, e 
    //uma função responsável por criar o banco de dados
    //na primeira vez que o abrirmos. Essa função
    //recebe 2 parâmetros: o banco de dados, e a nova
    //versão dele.
    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      //Aqui executamos o código responsável por criar
      //a tabela no banco de dados. Aqui executamos
      //SQL.
      await db.execute(
        "CREATE TABLE $contactTable($idColumn INTEGER PRIMARY KEY, $nameColumn TEXT, $emailColumn TEXT,"
        + "$phoneColumn TEXT, $imgColumn TEXT)"
      );
    });
  }

  Future<Contact> getContact(int id) async {
    Database dbContact = await db;
    //agora dessa vez fazemos uma query, 
    //uma consulta ao banco para obtermos os 
    //dados. Passamos de que tabela queremos 
    //filtrar, passamos os campos que queremos, e 
    //no where colocamos a condição, e o valor que 
    //será testado na condição colocamos um ? que 
    //será o valor pego no whereArgs.
    List<Map> maps = await dbContact.query(contactTable, 
      columns: [idColumn, nameColumn, emailColumn, phoneColumn, imgColumn],
      where: "$idColumn = ?",
      whereArgs: [id]
    );

    //Verificamos se há um contato com aquele id, e se
    //houver retornamos o map dele mas apenas do first
    //pois estamos filtrando o contato por um ID 
    //específico. Se não encontrar um contato retornamos
    //null.
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    }
    else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    Database dbContact = await db;
    //O delete retorna um número inteiro indicando se
    //a deleção foi realizada com sucesso ou não.
    return await dbContact.delete(contactTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    Database dbContact = await db;
    //Também retorna um inteiro que demonstra sucesso
    //ou não na operação.
    return await dbContact.update(contactTable, contact.toMap(), where: '$idColumn = ?', whereArgs: [contact.id]);
  }

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap = await dbContact.rawQuery("SELECT * FROM $contactTable");
    //Se não especificarmos que queremos uma lista do
    //tipo Contact ele seta como padrão dynamic, e é
    //interessante deixarmos tipado para prevenir erros
    List<Contact> listContact = List();
    for (Map m in listMap) {
      listContact.add(Contact.fromMap(m));
    }
    return listContact;
  }

  Future<int> getNumber() async {
    Database dbContact = await db;
    return Sqflite.firstIntValue(await dbContact.rawQuery("SELECT COUNT(*) FROM $contactTable"));
  }

  //Função para fechar o banco de dados
  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }

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

  Contact();

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