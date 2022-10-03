import 'package:apod/Pages/main_page.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height: 100,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Scaffold(
                        appBar: AppBar(
                          title: const Text('one of the title'),
                        ),
                        body: const MainPage());
                  }));
                },
                child: const Card(
                    elevation: 5.0,
                    child: Center(
                      child: Text(
                        'I am Image Title',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    )),
              ),
            ),
          );
        },
        itemCount: 2,
      ),
    );
  }
}
