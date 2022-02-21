import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_auth/main.dart';
import 'package:flutter_test_auth/screens/add_movie_page.dart';
import 'package:flutter_test_auth/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/firebase_auth.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Movie App'),
          leading: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AddPage();
                      },
                      fullscreenDialog: true,
                    ));
              }),
          actions: [
            IconButton(
                icon: const Icon(Icons.logout_outlined),
                onPressed: () {
                  context.read<FlutterFireAuthService>().signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                })
          ],
        ),
        body: const MoviesInformation());
  }
}

class MoviesInformation extends StatefulWidget {
  const MoviesInformation({Key? key}) : super(key: key);

  @override
  _MoviesInformationState createState() => _MoviesInformationState();
}

class _MoviesInformationState extends State<MoviesInformation> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final Stream<QuerySnapshot> _moviesStream = FirebaseFirestore.instance
        .collection('movies')
        .where('userId', isEqualTo: firebaseUser?.uid)
        .snapshots();

    void addLike(String docId, int likes) {
      var newLikes = likes + 1;
      try {
        FirebaseFirestore.instance
            .collection('movies')
            .doc(docId)
            .update({'likes': newLikes});
      } catch (e) {
        print(e.toString());
      }
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _moviesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          const Center(
              child: Text(
            'Impossible de charger votre liste de film, veuillez réessayer ultérieurement',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: accentColor,
            ),
          );
        }

        if (firebaseUser != null) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> movie =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: Image.network(movie['poster']),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie['name'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text('Anné de production : ' +
                              movie['year'].toString()),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              for (final categorie in movie['categories'])
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                    label: Text(categorie),
                                    backgroundColor: accentColor,
                                  ),
                                )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                iconSize: 20,
                                onPressed: () {
                                  addLike(document.id, movie['likes']);
                                },
                                icon: const Icon(Icons.favorite),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(movie['likes'].toString())
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: accentColor,
          ),
        );
      },
    );
  }
}
