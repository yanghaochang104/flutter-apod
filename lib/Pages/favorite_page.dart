import 'package:apod/Pages/main_page.dart';
import 'package:flutter/material.dart';

import '../main.dart';

import '../main.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Lunation Matrix'),
                  ),
                  body: const MainPage());
            }));
          },
          child: const Text('Navigate to MyHome Page')),
    );
  }
}
