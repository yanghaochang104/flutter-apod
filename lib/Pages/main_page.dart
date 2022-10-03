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
  late TextEditingController _controller;
  NoteType _noteType = NoteType.editable;
  @override
  void initState() {
    _controller = TextEditingController(text: 'Put your notes here!');
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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

    return SingleChildScrollView(
      child: FutureBuilder(
        future: _fetchDailyApodData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ApodData? data = snapshot.data;
            return Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  data != null ? data.title : '',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w500),
                ),
              ),
              Stack(
                children: [
                  SizedBox(
                    width: deviceScreen.width,
                    child: data != null
                        ? Image.network(data.url, frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          })
                        : SizedBox(
                            width: deviceScreen.width,
                            height: deviceScreen.width,
                            child: const Center(
                                child: Text(
                              '圖片載入錯誤',
                              style: TextStyle(color: Colors.red, fontSize: 30),
                            )),
                          ),
                  ),
                  Positioned(
                    top: 10.0,
                    right: 10.0,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white24),
                        onPressed: () {
                          print('add to favorite');
                        },
                        child: Icon(
                          Icons.favorite,
                          color: Colors.pink[200],
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  data != null ? data.desc : '',
                  style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
                ),
              ),
              _noteType == NoteType.text
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(_controller.text))),
                        Container(
                            width: 100,
                            padding: const EdgeInsets.all(10),
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  fixedSize: const Size(50, 50),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _noteType = NoteType.editable;
                                  });
                                },
                                child: const Icon(Icons.edit)))
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 100),
                              child: TextField(
                                controller: _controller,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none,
                                ),
                                maxLines: 5,
                                minLines: 3,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              fixedSize: const Size(50, 50),
                            ),
                            onPressed: () {
                              setState(() {
                                _noteType = NoteType.text;
                              });
                            },
                            child: const Icon(
                              Icons.save,
                            ),
                          ),
                        )
                      ],
                    ),
            ]);
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
      ),
    );
  }
}
