import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'dart:io';

import 'contact_page.dart';

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = List();

  @override 
  void initState(){
    super.initState();

    _getAllContacts();
  }

  /*
  //Esse código foi criado apenas para testes
    @override 
    void initState() {
      super.initState();

      /*
      Contact c = Contact();
      c.name = "Daniel Ciolfi";
      c.email = "daniel@gmail.com";
      c.phone = "3215616562";
      c.img = "imgtest";

      helper.saveContact(c);

      */

      Contact c = Contact();
      c.name = "Marcos";
      c.email = "marcos@gmail.com";
      c.phone = "465469459645";
      c.img = "imgtest2";

      helper.saveContact(c);

      helper.deleteContact(1);

      helper.getAllContacts()
      .then((list) {
        print(list);
      });
    }
  */

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        }
      )
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    //Cada contato irá estar dentro de um Card, que é 
    //um widget interessante para separar vários elementos
    //iguais. Mas esse Widget não tem ações nele como 
    //onPressed e etc, por isso colocaremos ele dentro
    //de um GestureDetector
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              //Para fazer uma imagem redonda, colocaremos
              //a imagem dentro de um container e o 
              //container faremos ficar redondo.
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contacts[index].img != null &&  FileSystemEntity.typeSync(contacts[index].img) != FileSystemEntityType.notFound ? 
                      FileImage(File(contacts[index].img)) :
                        AssetImage("images/person.png")
                  )
                )
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(contacts[index].name ?? "", 
                      style: TextStyle(fontSize: 22.0, 
                        fontWeight: FontWeight.bold)
                    ),
                    Text(contacts[index].email ?? "", 
                      style: TextStyle(fontSize: 18.0)
                    ),
                    Text(contacts[index].phone ?? "", 
                      style: TextStyle(fontSize: 18.0)
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
      onTap: () {
        _showContactPage(contact: contacts[index]);
      }
    );
  }

  void _showContactPage({Contact contact}) async {
    //Aqui recebemos o retorno da página que 
    //chamamos
    final recContact = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => ContactPage(contact: contact)
      )
    );
    //Quando clicamos em um contato, o alteramos e 
    //clicamos em salvar ele é retornado para o 
    //recContact. Mas se clicar em voltar é retornado 
    //null, e se não for alterado nada de um contato 
    //também é retornado null.
    if (recContact != null) {
      //Se o contact != null significa que estamos 
      //editando um contato e não salvando um já 
      //existente
      if (contact != null) {
        await helper.updateContact(recContact);
      }
      //Se não, se for um novo contato
      else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts()
      .then((list) {
        setState(() {
          contacts = list;
        });
      });
  }
}