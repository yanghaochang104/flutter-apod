import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '今日照片'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
                'https://apod.nasa.gov/apod/image/2209/WaterlessEarth2_woodshole_2520.jpg',
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            }),
            ElevatedButton(
                onPressed: () {
                  print('add to favorite');
                },
                child: const Text('favorite')),
            const Text(
              "How much of planet Earth is made of water? Very little, actually. Although oceans of water cover about 70 percent of Earth's surface, these oceans are shallow compared to the Earth's radius. The featured illustration shows what would happen if all of the water on or near the surface of the Earth were bunched up into a ball. The radius of this ball would be only about 700 kilometers, less than half the radius of the Earth's Moon, but slightly larger than Saturn's moon Rhea which, like many moons in our outer Solar System, is mostly water ice. The next smallest ball depicts all of Earth's liquid fresh water, while the tiniest ball shows the volume of all of Earth's fresh-water lakes and rivers. How any of this water came to be on the Earth and whether any significant amount is trapped far beneath Earth's surface remain topics of research.",
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: '月曆',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '主頁',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
