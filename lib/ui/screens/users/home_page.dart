import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/widgets/carousel_slider.dart';
import 'package:firebase/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser()!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data!.data();
            return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  SizedBox(height: 12),
                  CarouselPopularWidget(
                    userAdmin: data!['admin'],
                  ),
                ],
              ),
            );
          } else {
            return CircularProgressIndicator(color: Colors.amber);
          }
        });
  }
}
