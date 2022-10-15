import 'dart:convert';

import 'package:apod/utils/format_date.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../keys/api_key.dart';
import 'apod_data.dart';

class DailyApodState extends ChangeNotifier {
  final String apodUrl = 'https://api.nasa.gov/planetary/apod';

  ApodData dailyApod = ApodData('', '', '', '', '', '', false);

  Future<void> fetchDailyApodData() async {
    if (dailyApod.date.isNotEmpty &&
        dailyApod.date == formatDate(DateTime.now())) {
      // 如果當前資料日期和今天重複，代表已經取得當天的APOD了，不必再重新call api取一次
      return;
    }

    Uri url = Uri.parse('$apodUrl?api_key=$apiKey&thumbs=true');
    final response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    final parsedResponse = json.decode(response.body) as Map<String, dynamic>;
    dailyApod = ApodData.fromJson(parsedResponse);

    notifyListeners();
  }
}
