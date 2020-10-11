import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contact_helper.dart';

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
          
        }
      )
    );
  }
}