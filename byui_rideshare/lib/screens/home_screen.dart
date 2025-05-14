import 'package:flutter/material.dart';
// You might need other imports later, e.g., for Firebase Auth to sign out

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Home!'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('You have successfully logged in!'),
      ),
      // You might want a Sign Out button here later
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // TODO: Implement sign out logic using FirebaseAuth
      //   },
      //   tooltip: 'Sign Out',
      //   child: const Icon(Icons.logout),
      // ),
    );
  }
}