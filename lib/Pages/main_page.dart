import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const Text('Lunation Matrix'),
          Stack(
            children: [
              Container(
                constraints: BoxConstraints(minHeight: deviceWidth),
                width: deviceWidth,
                child: Image.network(
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
              ),
              Positioned(
                top: 10.0,
                right: 10.0,
                child: ElevatedButton(
                    onPressed: () {
                      print('add to favorite');
                    },
                    child: const Text('favorite')),
              ),
            ],
          ),
          const Text(
            "How much of planet Earth is made of water? Very little, actually. Although oceans of water cover about 70 percent of Earth's surface, these oceans are shallow compared to the Earth's radius. The featured illustration shows what would happen if all of the water on or near the surface of the Earth were bunched up into a ball. The radius of this ball would be only about 700 kilometers, less than half the radius of the Earth's Moon, but slightly larger than Saturn's moon Rhea which, like many moons in our outer Solar System, is mostly water ice. The next smallest ball depicts all of Earth's liquid fresh water, while the tiniest ball shows the volume of all of Earth's fresh-water lakes and rivers. How any of this water came to be on the Earth and whether any significant amount is trapped far beneath Earth's surface remain topics of research.",
            style: TextStyle(fontSize: 12, color: Colors.blueGrey),
          ),
        ],
      ),
    );
  }
}
