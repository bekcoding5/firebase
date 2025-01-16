import 'package:firebase/firebase_options.dart';
import 'package:firebase/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LLoginScreen2(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Bottom Navigation uchun index

  final List<Widget> _pages = [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Category Page', style: TextStyle(fontSize: 24))),
    const LiveTVPage(),
  ];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Har bir bo'limni ko'rsatish
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber,
        currentIndex: _currentIndex, // Tanlangan bo'limni ko'rsatish
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live TV',
          ),
        ],
      ),
    );
  }
}

class LiveTVPage extends StatelessWidget {
  const LiveTVPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live TV Page'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Live TV Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
