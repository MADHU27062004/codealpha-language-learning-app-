import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'profile_page.dart';
import 'lesson_page.dart'; 
import 'quiz_screen.dart'; 
import 'flashcard_screen.dart';// 👈 Make sure this file exists

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
  icon: Icon(Icons.book),
  tooltip: "Lessons",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LessonPage()),
    );
  },
),
          IconButton(
            icon: Icon(Icons.account_circle),
            tooltip: "Profile",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          ElevatedButton(
  child: Text("Start Quiz"),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const QuizScreen()),
    );
  },
),
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FlashcardScreen()),
    );
  },
  child: Text('Go to Flashcards'),
),


        ],
      ),
      body: Center(
        child: Text(
          "Welcome to the Language Learning App!\n\nLogged in as: ${user?.email ?? 'Unknown'}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}


