import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // --- Corrected Email/Password Sign In Method ---
  Future<void> _signInWithEmailAndPassword() async {
    try {
      // Show a loading indicator (optional)

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (userCredential.user != null) {
        print('User signed in: ${userCredential.user!.uid}');
        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()), // Use your actual Home Screen widget
        );
      }

      // Hide the loading indicator

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong password provided.')),
        );
      } else {
        print('Firebase Auth error: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${e.message}')),
        );
      }
      // Hide the loading indicator on error

    } catch (e) {
      print('An unexpected error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
      // Hide the loading indicator on error
    }
  }

  // --- Corrected Google Sign In Method for Mobile ---
  Future<void> _signInWithGoogle() async {
    try {
      // Show a loading indicator (optional)

      // Trigger the Google Sign In flow on the device
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth != null) {
        // Create a new credential with the access token and id token
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Sign in to Firebase with the Google credential
        UserCredential firebaseUserCredential = await _auth.signInWithCredential(credential);

        if (firebaseUserCredential.user != null) {
          print('Google Sign In successful: ${firebaseUserCredential.user!.uid}');
          // Navigate to the home screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()), // Use your actual Home Screen widget
          );
        }
      } else {
        print('Google Sign In aborted by user or failed to get auth details.');
        // Optionally show a message that the sign-in was cancelled
      }

      // Hide the loading indicator

    } on FirebaseAuthException catch (e) {
      print('Firebase Auth error during Google Sign In: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google Sign In failed: ${e.message}')),
      );
    } catch (e) {
      print('An unexpected error occurred during Google Sign In: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: _signInWithEmailAndPassword,
              child: const Text('Sign In with Email'),
            ),
            SizedBox(height: 12),

            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: const Text('Sign In with Google'),
            ),

            TextButton(
              onPressed: () {
                // TODO: Navigate to Forgot Password screen
              },
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: () {
                // TODO: Navigate to Create Account screen
              },
              child: const Text('Create Account'),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for HomeScreen - move this to screens/home_screen.dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome Home!')),
      body: const Center(child: Text('You are logged in!')),
    );
  }
}