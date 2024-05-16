import 'package:contacts_app/common/input.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerMail = TextEditingController();
  TextEditingController controllerTelephone = TextEditingController();
  @override
  void initState() {
    controllerName = TextEditingController();
    controllerMail = TextEditingController();
    controllerTelephone = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add contact',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    InputWidget('Name', controllerName,
                        const TextStyle(color: Colors.black), false),
                    const SizedBox(
                      height: 20,
                    ),
                    InputWidget('Mail', controllerMail,
                        const TextStyle(color: Colors.black), false),
                    const SizedBox(
                      height: 20,
                    ),
                    InputWidget('Telephone', controllerTelephone,
                        const TextStyle(color: Colors.black), false),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              String name = controllerName.text;
                              String mail = controllerMail.text;
                              String telephone = controllerTelephone.text;

                              if (name.isNotEmpty &&
                                  mail.isNotEmpty &&
                                  telephone.isNotEmpty) {
                                //TODO Don't send ID
                                Navigator.pop(
                                    context,
                                    Contact(
                                        id: 0,
                                        name: name,
                                        mail: mail,
                                        telephone: telephone));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shadowColor: Colors.black,
                                elevation: 6.0,
                                minimumSize: const Size(150, 40),
                                side: const BorderSide(
                                    color: Colors.white,
                                    width: 0.5,
                                    style: BorderStyle.solid),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0)),
                                textStyle: const TextStyle(fontSize: 18)),
                            child: const Text('Save',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)))
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
    );
  }
}
