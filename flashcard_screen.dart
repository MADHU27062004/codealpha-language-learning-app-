import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter_tts/flutter_tts.dart';


class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  final FlutterTts flutterTts = FlutterTts();
  String selectedLanguage = 'Tamil-English';

  final GlobalKey<FlipCardState> flipKey = GlobalKey<FlipCardState>();

  final Map<String, List<Map<String, String>>> flashcards = {
    'Tamil-English': [
      {'மரம்': 'Tree'},
      {'தம்பி': 'Brother'},
      {'மாமா': 'Uncle'},
      {'நிறுவனர்': 'Founder'},
      {'அக்கா': 'Elder Sister'},
      {'குரு': 'Teacher'},
      {'ஆளுநர்': 'Governor'},
      {'அம்மா': 'Mother'},
      {'அப்பா': 'Father'},
      {'அத்தை': 'Aunt (Father’s Sister)'},
      {'சித்தி': 'Aunt (Mother’s Sister)'},
      {'சித்தப்பா': 'Uncle (Mother’s Sister’s Husband)'},
      {'பாட்டி': 'Grandmother'},
      {'தாத்தா': 'Grandfather'},
      {'நண்பன்': 'Friend (Male)'},
      {'நண்பி': 'Friend (Female)'},
      {'மாணவர்': 'Student'},
      {'ஆசிரியர்': 'Teacher'},
      {'பெண் குழந்தை': 'Girl Child'},
      {'ஆண் குழந்தை': 'Boy Child'},
    ],
    'English-Hindi': [
      {'Tree': 'पेड़'},
      {'Brother': 'भाई'},
      {'Uncle': 'चाचा'},
      {'Founder': 'संस्थापक'},
      {'Elder Sister': 'दीदी'},
      {'Teacher': 'शिक्षक'},
      {'Governor': 'राज्यपाल'},
      {'Mother': 'माँ'},
      {'Father': 'पिता'},
      {'Aunt': 'चाची'},
    ],
    'Hindi-Tamil': [
      {'पेड़': 'மரம்'},
      {'भाई': 'தம்பி'},
      {'चाचा': 'மாமா'},
      {'संस्थापक': 'நிறுவனர்'},
      {'दीदी': 'அக்கா'},
      {'शिक्षक': 'ஆசிரியர்'},
      {'राज्यपाल': 'ஆளுநர்'},
      {'माँ': 'அம்மா'},
      {'पिता': 'அப்பா'},
      {'चाची': 'அத்தை'},
    ],
  };

  int cardIndex = 0;

  void _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final cards = flashcards[selectedLanguage]!;
    final frontText = cards[cardIndex].keys.first;
    final backText = cards[cardIndex].values.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('📚 Flashcards'),
        backgroundColor: Colors.deepPurple,
        actions: [
          DropdownButton<String>(
            value: selectedLanguage,
            dropdownColor: Colors.deepPurple[50],
            underline: const SizedBox(),
            icon: const Icon(Icons.language, color: Colors.white),
            onChanged: (value) {
              setState(() {
                selectedLanguage = value!;
                cardIndex = 0;
              });
            },
            items: flashcards.keys
                .map((lang) => DropdownMenuItem(
                      value: lang,
                      child: Text(lang,
                          style: const TextStyle(color: Colors.black)),
                    ))
                .toList(),
          ),
        ],
      ),
      backgroundColor: Colors.purple[50],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => flipKey.currentState?.toggleCard(),
            child: FlipCard(
              key: flipKey,
              front: FlashcardWidget(
                text: frontText,
                color: Colors.pinkAccent,
                onSpeak: () => _speak(frontText),
              ),
              back: FlashcardWidget(
                text: backText,
                color: Colors.lightGreen,
                onSpeak: () => _speak(backText),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: cardIndex > 0
                    ? () {
                        setState(() {
                          cardIndex--;
                        });
                      }
                    : null,
                child: const Text("⏮️ Prev"),
              ),
              const SizedBox(width: 20),
              ElevatedButton(
                onPressed: cardIndex < cards.length - 1
                    ? () {
                        setState(() {
                          cardIndex++;
                        });
                      }
                    : null,
                child: const Text("Next ⏭️"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class FlashcardWidget extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onSpeak;

  const FlashcardWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onSpeak,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              IconButton(
                icon: const Icon(Icons.volume_up_rounded),
                onPressed: onSpeak,
              )
            ],
          ),
        ),
      ),
    );
  }
}
