import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 39, 39, 39),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'Gold Signal 100%',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 182, 142, 0),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 200.0,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
              ),
              items: [
                'https://via.placeholder.com/600x200?text=Ad+1',
                'https://via.placeholder.com/600x200?text=Ad+1',
                'https://via.placeholder.com/600x200?text=Ad+1',
                'https://via.placeholder.com/600x200?text=Ad+1'
              ].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () => _carouselItemTapped(context, i),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(i, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: LHero(),
          ),
        ],
      ),
    );
  }

  void _carouselItemTapped(BuildContext context, String imageUrl) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext ctx) => Scaffold(
        appBar: AppBar(
          title: const Text('Carousel Item Detail'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(imageUrl),
              const SizedBox(height: 20),
              const Text('Detailed view of the carousel item.'),
            ],
          ),
        ),
      ),
    ));
  }
}

class LHero extends StatefulWidget {
  const LHero({super.key});

  @override
  State<LHero> createState() => _LHeroState();
}

class _LHeroState extends State<LHero> {
  Widget _smallImage(Color color) {
    return Container(
      width: 50,
      height: 50,
      color: color,
    );
  }

  Widget _bigImage(Color color) {
    return Container(
      width: 300,
      height: 300,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List<Widget>.generate(10, (int index) {
        final Color color =
            Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                .withOpacity(1.0);
        final Key n1 = GlobalKey();
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: GestureDetector(
                key: n1,
                child: Hero(
                  tag: index.toString(),
                  child: _smallImage(color),
                ),
                onTap: () => _fullImagePage(context, color, index.toString()),
              ),
              title: const Text('gold'),
            ));
      }),
    );
  }

  void _fullImagePage(BuildContext context, Color color, String tag) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext ctx) => Scaffold(
        appBar: AppBar(
          title: const Text('Big Image'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: tag,
                child: _bigImage(color),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
