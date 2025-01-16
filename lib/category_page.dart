// import 'dart:math';
// import 'package:flutter/material.dart';

// class CategoryPage extends StatelessWidget {
//   const CategoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const LHero(); // Hero animatsiyasi uchun LHero widgetini qo'shamiz
//   }
// }

// class LHero extends StatefulWidget {
//   const LHero({super.key});

//   @override
//   State<LHero> createState() => _LHeroState();
// }

// class _LHeroState extends State<LHero> {
//   // Kichik rasmni yaratish uchun metod
//   Widget _smallImage(Color color) {
//     return Container(
//       width: 50,
//       height: 50,
//       color: color,
//     );
//   }

//   // Katta rasmni yaratish uchun metod
//   Widget _bigImage(Color color) {
//     return Container(
//       width: 300,
//       height: 300,
//       color: color,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Hero animatsiyasini ko'rsatadigan ListView
//     return ListView(
//       children: List<Widget>.generate(10, (int index) {
//         final Color color = Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
//         final Key n1 = GlobalKey();
        
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: ListTile(
//             leading: GestureDetector(
//               key: n1,
//               child: Hero(
//                 tag: index.toString(),
//                 child: _smallImage(color),
//               ),
//               onTap: () => _fullImagePage(context, color, index.toString()),  // Kichik rasmni bosganda kattaroq ko'rsatish
//             ),
//             title: const Text('gold'), // List item title
//           ),
//         );
//       }),
//     );
//   }

//   // Katta rasmni ko'rsatish uchun yangi sahifaga o'tish
//   void _fullImagePage(BuildContext context, Color color, String tag) {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (BuildContext ctx) => Scaffold(
//         appBar: AppBar(
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Hero(
//                 tag: tag,
//                 child: _bigImage(color),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: CategoryPage(), // CategoryPage ni boshlash
//   ));
// }



