import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
final List<Question> questions = [
  // Greetings
  Question(
    text: "How do you say 'Good Morning' in Tamil?",
    options: ["வணக்கம்", "காலை வணக்கம்", "இரவு வணக்கம்", "மகிழ்ச்சி"],
    correctIndex: 1,
  ),
  Question(
    text: "How do you say 'Hello' in Hindi?",
    options: ["नमस्ते", "शुभ रात्रि", "धन्यवाद", "सुप्रभात"],
    correctIndex: 0,
  ),
  Question(
    text: "'Good Night' in Tamil?",
    options: ["இரவு வணக்கம்", "காலை வணக்கம்", "வணக்கம்", "மதிய வணக்கம்"],
    correctIndex: 0,
  ),
  Question(
    text: "'How are you?' in Hindi?",
    options: ["तुम कहाँ हो?", "क्या कर रहे हो?", "आप कैसे हैं?", "मुझे माफ़ करो"],
    correctIndex: 2,
  ),
  Question(
    text: "What is 'Thank you' in Tamil?",
    options: ["மன்னிக்கவும்", "நன்றி", "வணக்கம்", "இல்லை"],
    correctIndex: 1,
  ),

  // Numbers
  Question(
    text: "What is 'One' in Hindi?",
    options: ["दो", "एक", "तीन", "चार"],
    correctIndex: 1,
  ),
  Question(
    text: "What is 'Ten' in Tamil?",
    options: ["ஒன்று", "பத்து", "ஐந்து", "நான்கு"],
    correctIndex: 1,
  ),
  Question(
    text: "Translate 'Three' into Tamil.",
    options: ["மூன்று", "இரண்டு", "நான்கு", "ஒன்று"],
    correctIndex: 0,
  ),
  Question(
    text: "What is 'Five' in Hindi?",
    options: ["तीन", "छह", "पाँच", "दो"],
    correctIndex: 2,
  ),
  Question(
    text: "Translate 'Seven' into Tamil.",
    options: ["ஏழு", "ஆறு", "ஒன்று", "அஞ்சு"],
    correctIndex: 0,
  ),

  // Basic Phrases
  Question(
    text: "'Where are you?' in Hindi?",
    options: ["कहाँ हो?", "तुम कौन हो?", "कैसे हो?", "क्या है?"],
    correctIndex: 0,
  ),
  Question(
    text: "'I don't understand' in Tamil?",
    options: ["தெரியவில்லை", "நன்றி", "மன்னிக்கவும்", "அருமை"],
    correctIndex: 0,
  ),
  Question(
    text: "'Please' in Hindi?",
    options: ["माफ़ करो", "कृपया", "शुभ रात्रि", "नमस्ते"],
    correctIndex: 1,
  ),
  Question(
    text: "How do you say 'Sorry' in Tamil?",
    options: ["மன்னிக்கவும்", "அருமை", "இரவு வணக்கம்", "நன்றி"],
    correctIndex: 0,
  ),
  Question(
    text: "'Goodbye' in Hindi?",
    options: ["शुभ रात्रि", "अलविदा", "नमस्ते", "कृपया"],
    correctIndex: 1,
  ),
];
int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  int? selectedIndex;
  void storeQuizResult(int score, int total) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await FirebaseFirestore.instance.collection('quiz_results').add({
      'userId': user.uid,
      'score': score,
      'total': total,
      'timestamp': Timestamp.now(),
    });
    print("✅ Quiz result stored in Firestore");
  } else {
    print("❌ No user signed in");
  }
}


  void _nextQuestion() {
    setState(() {
      if (selectedIndex == questions[currentQuestion].correctIndex) {
        score++;
      }
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        selectedIndex = null;
        answered = false;
      } else {
        _showScoreDialog();
      }
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Quiz Complete 🎉"),
        content: Text("Your score: $score / ${questions.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestion = 0;
                score = 0;
                selectedIndex = null;
                answered = false;
              });
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz: Greetings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: Column(
            key: ValueKey(currentQuestion),
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Question ${currentQuestion + 1}/${questions.length}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                question.text,
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 20),
              ...List.generate(question.options.length, (index) {
                final isSelected = selectedIndex == index;
                final isCorrect = question.correctIndex == index;

                Color getColor() {
                  if (!answered) return Colors.blue.shade200;
                  if (isSelected && isCorrect) return Colors.green;
                  if (isSelected && !isCorrect) return Colors.red;
                  if (isCorrect) return Colors.green.shade200;
                  return Colors.grey.shade300;
                }

                return GestureDetector(
                  onTap: () {
                    if (!answered) {
                      setState(() {
                        selectedIndex = index;
                        answered = true;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: getColor(),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      question.options[index],
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                );
              }),
              const Spacer(),
              ElevatedButton(
                onPressed: answered ? _nextQuestion : null,
                child: Text(currentQuestion == questions.length - 1 ? "Finish" : "Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
  });
}

