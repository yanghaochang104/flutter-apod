import 'package:flutter/material.dart';

import 'apod_data.dart';

class FavoriteState extends ChangeNotifier {
  List<ApodData> favoriteList = [];

  void addToList(ApodData apodData) {
    favoriteList.add(apodData); // dart的list內建的方法，可以在List內部新增元素
    notifyListeners(); // 通知使用到這個data model的UI重新渲染
  }

  void removeFromList(ApodData apodData) {
    favoriteList.remove(apodData); // dart的list內建的方法，移除List內部特定元素
    notifyListeners(); // 通知使用到這個data model的UI重新渲染
  }
}
