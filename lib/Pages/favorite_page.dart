import 'package:apod/model/favorite_state.dart';
import 'package:apod/widgets/astro_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/apod_data.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<FavoriteState>(
          // 透過context, 取用上層傳進來的Favorite Provider
          builder: (context, favoriteState, child) {
        List<ApodData> list = favoriteState.favoriteList;
        return list.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: 100,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Scaffold(
                                appBar: AppBar(
                                  title: Text(list[index].date),
                                ),
                                body: ChangeNotifierProvider.value(
                                    // 使用.value constructor，沿用目前的favoriteState instance到下一頁
                                    value:
                                        favoriteState, // 目前包含在context之中的favoriteState instance
                                    child:
                                        AstroPicture(apodData: list[index])));
                          }));
                        },
                        child: Card(
                            elevation: 5.0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(list[index].date,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[400])),
                                  Text(
                                    list[index].title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ])),
                      ),
                    ),
                  );
                },
                itemCount: favoriteState.favoriteList.length,
              )
            : Center(
                child: Text(
                  '目前沒有收藏！',
                  style: TextStyle(fontSize: 30, color: Colors.grey[400]),
                ),
              );
      }),
    );
  }
}
