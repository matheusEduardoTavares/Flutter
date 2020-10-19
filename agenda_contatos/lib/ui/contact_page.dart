import 'dart:io';

import 'package:flutter/material.dart';
import 'package:agenda_contatos/helpers/contact_helper.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  //Esse construtor servirá para passarmos o 
  //contato que queremos editar nesta página.
  //Colocaremos o parâmetro this.contact dentro
  //de chaves pois ele será opcional, essa página
  //será aberta tanto para criar um novo contato
  //quanto para editar um contato. E só iremos
  //precisar desse parâmetro this.contact quando
  //formos editar um contato.
  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  
  //Estamos criando um foco
  final _nameFocus = FocusNode();

  bool _userEdited = false;

  Contact _editedContact;

  @override 
  void initState() {
    super.initState();

    //widget é o ContactPage, a classe pai, e o contact
    //é o seu atributo.
    if(widget.contact == null){
      //Se o contato for null significa que o usuário
      //está criando um novo contato.
      _editedContact = Contact();
    }
    else {
      //Se não pegamos o contato que está sendo editado
      //e colocamos ele na variável _editedContact.
      _editedContact = Contact.fromMap(widget.contact.toMap());
      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editedContact.name ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_editedContact.name != null && _editedContact.name.isNotEmpty) {
            //Será removido a tela e irá voltar para a
            //tela anterior. O Navigator funciona com 
            //esquema de pilha. No pop passamos o 
            //context e o segundo parâmetro é o que 
            //queremos retornar no local que chamar essa
            //rota, no caso, retornaremos o usuário.
            Navigator.pop(context, _editedContact);
          }
          else {
            //Aqui requisitamos que o foco passe a ser o 
            //text field do nome
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Container(
                height: 140.0,
                width: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _editedContact.img != null && FileSystemEntity.typeSync(_editedContact.img) != FileSystemEntityType.notFound ?
                    FileImage(File(_editedContact.img)) :
                    AssetImage("images/person.png")
                  )
                )
              ),
            ),
            TextField(
              controller: _nameController,
              focusNode: _nameFocus,
              decoration: InputDecoration(
                labelText: "Nome"
              ),
              onChanged: (text) {
                _userEdited = true;
                setState(() {
                  _editedContact.name = text;
                });
              }
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "Email"
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.email = text;
              },
              keyboardType: TextInputType.emailAddress
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone"
              ),
              onChanged: (text) {
                _userEdited = true;
                _editedContact.phone = text;
              },
              keyboardType: TextInputType.phone
            )
          ],
        )
      ),
    );
  }
}