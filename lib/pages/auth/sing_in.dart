import 'dart:convert';

import 'package:contacts_app/common/input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SingInPage extends StatefulWidget {
  const SingInPage({super.key});

  @override
  State<SingInPage> createState() => _SingInPageState();
}

class _SingInPageState extends State<SingInPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final urlApi = dotenv.env['API_HOST'];

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.transparent,
        body: Stack(
      children: [
        Container(),
        Container(
          padding: const EdgeInsets.only(left: 35, top: 130),
          child: const Text(
            'Sign In',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 33,
                fontWeight: FontWeight.bold),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 35),
                  child: Column(
                    children: [
                      InputWidget('Username', username,
                          const TextStyle(color: Colors.black), false),
                      const SizedBox(
                        height: 30,
                      ),
                      InputWidget('Password', password,
                          const TextStyle(color: Colors.black), true),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: IconButton(
                                color: Colors.white,
                                onPressed: () => {singIn(username, password)},
                                icon: const Icon(
                                  Icons.arrow_forward,
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }

  singIn(TextEditingController username, TextEditingController password) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    var url = Uri.parse('$urlApi/token/');
    Map body = {'username': username.text, 'password': password.text};
    username.clear();
    password.clear();
    var response = await http.post(url, body: body);
    var responseBody = jsonDecode(response.body);
    if (response.statusCode != 200) {
      username.clear();
      password.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Incorrect user or password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red,
      ));
    } else {
      storage.setString('access', responseBody['access']);
      Navigator.pushNamed(context, '/');
    }
  }
}
