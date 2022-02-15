import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../auth/firebase_auth.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgroundImage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home View'),
            IconButton(
              onPressed: () {
                context.read<FlutterFireAuthService>().signOut();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
