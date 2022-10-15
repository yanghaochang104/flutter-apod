import 'package:apod/model/daily_apod_state.dart';
import 'package:apod/widgets/astro_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchApodData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchApodData() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<DailyApodState>(context, listen: false)
        .fetchDailyApodData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceScreen = MediaQuery.of(context).size;

    return _isLoading
        ? SizedBox(
            height: deviceScreen.height,
            width: deviceScreen.width,
            child: const Center(child: CircularProgressIndicator()))
        : Consumer<DailyApodState>(
            builder: (context, dailyApodState, child) {
              return AstroPicture(apodData: dailyApodState.dailyApod);
            },
          );
  }
}
