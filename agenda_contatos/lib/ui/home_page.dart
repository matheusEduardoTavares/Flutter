import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'dart:io';

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

    helper.getAllContacts()
      .then((list) {
        setState(() {
          contacts = list;
        });
      });
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
        onPressed: () {},
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
                    image: contacts[index].img != null ? 
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
    );
  }
}