import '../screens/users/home_page.dart'; // To'g'ri import yo'li
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore uchun import

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class LLoginScreen2 extends StatefulWidget {
  const LLoginScreen2({Key? key}) : super(key: key);

  @override
  _LLoginScreen2State createState() => _LLoginScreen2State();
}

class _LLoginScreen2State extends State<LLoginScreen2> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isLoading = false; // CircularProgressIndicator uchun o'zgaruvchi

  // Google orqali tizimga kirish
  Future<void> _signInWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // Foydalanuvchi tizimga kirishni bekor qildi
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Firestore-ga foydalanuvchi ma'lumotlarini tekshirish
        final docRef = _firestore.collection('users').doc(user.uid);
        final docSnapshot = await docRef.get();

        if (!docSnapshot.exists) {
          // Foydalanuvchi mavjud bo'lmasa, yangi foydalanuvchi ma'lumotlarini yaratish
          await docRef.set({
            'username': user.displayName?.trim() ?? 'No Name',
            'userId': user.uid,
            'email': user.email ?? 'No Email',
            'admin': false,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      // Xatolikni ko'rsatish
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png', height: 250),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 25,
                    ),
                    label: const Text('Sign in with Google'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: _signInWithGoogle,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
