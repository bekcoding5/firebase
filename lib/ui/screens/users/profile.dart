import 'package:firebase/ui/screens/admin/add_posts.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
          onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddPostScreen(),
                ),
              ),
          child: Text('AddPost')),
    );
  }
}
