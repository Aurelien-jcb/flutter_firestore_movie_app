import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_auth/main.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect/multiselect.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _posterController = TextEditingController();
  List<String> categories = [];
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un film'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            ListTile(
              title: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Nom :',
                    ),
                    controller: _nameController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Année :',
                    ),
                    controller: _yearController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      hintText: 'Affiche :',
                    ),
                    controller: _posterController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildMultiselect(),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('movies').add({
                        'name': _nameController.value.text,
                        'year': _yearController.value.text,
                        'poster': _posterController.value.text,
                        'categories': categories,
                        'likes': 0,
                        'userId': firebaseUser?.uid,
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Ajouter'),
                    style: ElevatedButton.styleFrom(
                      primary: accentColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildMultiselect() {
    return DropDownMultiSelect(
      onChanged: (List<String> x) {
        setState(() {
          categories = x;
        });
      },
      decoration: const InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
      ),
      options: const ['Action', 'Science fiction', 'Aventure', 'Comédie'],
      selectedValues: categories,
      whenEmpty: 'Sélectionner une catégorie',
    );
  }
}
