import 'package:apod/widgets/astro_picture.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../keys/api_key.dart';
import '../model/apod_data.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

enum NoteType {
  text,
  editable,
}

class _MainPageState extends State<MainPage> {
  final String apodUrl = 'https://api.nasa.gov/planetary/apod';
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<ApodData?> _fetchDailyApodData() async {
    Uri url = Uri.parse('$apodUrl?api_key=$apiKey&thumbs=true');
    final response = await http.get(url, headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });

    final parsedResponse = json.decode(response.body) as Map<String, dynamic>;
    return ApodData.fromJson(parsedResponse);
  }

  @override
  Widget build(BuildContext context) {
    Size deviceScreen = MediaQuery.of(context).size;

    return FutureBuilder(
      future: _fetchDailyApodData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ApodData? data = snapshot.data;
          return AstroPicture(
            title: data?.title ?? '',
            pictureUrl: data?.url ?? '',
            desc: data?.desc ?? '',
            note: 'Place your note here!', // 待日後將儲存的筆記放進來
            isFavorite: false, // 待日後將收藏狀態放進來
          );
        }
        if (snapshot.hasError) {
          return const Center(
              child: Text(
            '頁面載入錯誤',
            style: TextStyle(color: Colors.red, fontSize: 30),
          ));
        }
        return SizedBox(
            height: deviceScreen.height,
            width: deviceScreen.width,
            child: const Center(child: CircularProgressIndicator()));
      },
    );
  }
}
