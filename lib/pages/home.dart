
import 'dart:convert';

import 'package:contacts_app/models/contact.dart';
import 'package:contacts_app/pages/auth/sing_in.dart';
import 'package:contacts_app/pages/contacts/edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences storage;
  final urlApi = dotenv.env['API_HOST'];
  List<Contact> _contacts = [];
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  isLogin() async {
    storage = await SharedPreferences.getInstance();
    if (storage.get('access') == null) {
      Navigator.pushNamed(context, '/login');
    } else {
      getContacts();
    }
  }

  Future<void> getContacts() async {
    storage = await SharedPreferences.getInstance();
    List<Contact> contacts = [];
    var url = Uri.parse('$urlApi/contacts');
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${storage.get('access')}',
    });
    var json = jsonDecode(response.body);
    for (var contact in json) {
      contacts.add(Contact(
          id: contact['id'],
          name: contact['name'],
          mail: contact['mail'],
          telephone: contact['telephone']));
    }
    setState(() {
      _contacts = contacts;
    });
  }

  void saveContact(contact) async {
    storage = await SharedPreferences.getInstance();
    var url = Uri.parse('$urlApi/contacts/create');
    Map body = {
      'name': contact.name,
      'mail': contact.mail,
      'telephone': contact.telephone
    };
    var response = await http.post(url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer ${storage.get('access')}',
        },
        body: body);
    if (response.statusCode == 201) {
      getContacts();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Contact edit successfully", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ));
    }
  }
  void updateContact(id,contact) async {
  storage = await SharedPreferences.getInstance();
    var url = Uri.parse('$urlApi/contacts/update/$id');
    Map body = {
      'name': contact.name,
      'mail': contact.mail,
      'telephone': contact.telephone
    };
    var response = await http.put(url,headers: {HttpHeaders.authorizationHeader: 'Bearer ${storage.get('access')}',}, body: body);
    if (response.statusCode == 200) {
      getContacts();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Contact modified successfully", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ));
    }
  }
  void deleteContact(id) async {
    storage = await SharedPreferences.getInstance();
    var url = Uri.parse('$urlApi/contacts/delete/$id');
    var response = await http.delete(url,headers: {HttpHeaders.authorizationHeader: 'Bearer ${storage.get('access')}',});
    if (response.statusCode == 204) {
      getContacts();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Contact deleted successfully", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Contacts',
            style: TextStyle(
                color: Colors.white,
                fontSize: 27,
                fontWeight: FontWeight.bold)),
        toolbarHeight: 65,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              storage.remove('access');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SingInPage()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_contacts[index].name),
            subtitle: Text(_contacts[index].telephone),
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                _contacts[index].name.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    color: Colors.black,
                    onPressed: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => EditContactPage(_contacts[index]))).then((contact) => {
                        if (contact != null) {updateContact(_contacts[index].id,contact)}
                      })
                    },
                    icon: const Icon(Icons.edit)),
                IconButton(
                    color: Colors.red,
                    onPressed: () => {deleteContact(_contacts[index].id)},
                    icon: const Icon(Icons.delete)),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => {
          Navigator.pushNamed(context, '/add_contact').then((contact) => {
                if (contact != null) {saveContact(contact)}
              })
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
