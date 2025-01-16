import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class LLoginScreen2 extends StatefulWidget {
  const LLoginScreen2({super.key});

  @override
  _LLoginScreen2State createState() => _LLoginScreen2State();
}

class _LLoginScreen2State extends State<LLoginScreen2> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _auth.signInAnonymously();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'Something went wrong!';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images6.jpg'), // Fon rasmi
            fit: BoxFit.cover, // Butun ekranni qoplaydi
          ),
        ),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Kontent joylashgan joy
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            // Qoraytirilgan fon
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(56.0),
                              topRight: Radius.circular(56.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                const TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                  ),
                                ),
                                const SizedBox(height: 36.0),
                                if (_errorMessage.isNotEmpty)
                                  Text(
                                    _errorMessage,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                const SizedBox(height: 16.0),
                                _isLoading
                                    ? const CircularProgressIndicator()
                                    : FloatingActionButton(
                                        onPressed: _signIn,
                                        backgroundColor: Colors.yellow,
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.black,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
 
