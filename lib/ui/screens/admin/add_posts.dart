import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/ui/widgets/buy_sell_swich.dart';
import 'package:firebase/ui/widgets/myelevatedbutton.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _infoController = TextEditingController();
  bool _isLoading = false;
  bool _isBuySelected = true;

  // Firestorega ma'lumotlarni yuborish
  Future<void> _submitData() async {
    if (_infoController.text.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Generate a random ID for the new post document
      final postId = FirebaseFirestore.instance.collection('posts').doc().id;

      // Firestorega postni saqlash
      await FirebaseFirestore.instance.collection('posts').doc(postId).set({
        'info': _infoController.text,
        'type': _isBuySelected ? 'Buy' : 'Sell',
        'time': Timestamp.now(),
      });

      // Formani tozalash
      _infoController.clear();

      // Yangi postni yuborganingizdan keyin ekranni yopish
      Navigator.pop(context);
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: _infoController,
              decoration: const InputDecoration(
                labelText: 'Post Info',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            BuySellSwitch(
              isBuySelected: _isBuySelected,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MyElevatedButtonWithLogin(
            onTap: _submitData, text: 'Signal Qoshish'),
      ),
    );
  }
}
