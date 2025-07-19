import 'package:flutter/material.dart';

class LessonPage extends StatelessWidget {
  const LessonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('📚 Language Lessons'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'தமிழ்'),
              Tab(text: 'English'),
              Tab(text: 'हिन्दी'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LanguageTab(color: Colors.pinkAccent, language: 'Tamil'),
            LanguageTab(color: Colors.lightBlue, language: 'English'),
            LanguageTab(color: Colors.orangeAccent, language: 'Hindi'),
          ],
        ),
      ),
    );
  }
}

class LanguageTab extends StatelessWidget {
  final Color color;
  final String language;

  const LanguageTab({
    super.key,
    required this.color,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: color.withOpacity(0.1),
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          TopicCard(title: 'Greetings', phrases: _getGreetings(language), color: color),
          TopicCard(title: 'Numbers (1-10)', phrases: _getNumbers(language), color: color),
          TopicCard(title: 'Basic Phrases', phrases: _getBasicPhrases(language), color: color),
        ],
      ),
    );
  }
}

class TopicCard extends StatelessWidget {
  final String title;
  final List<String> phrases;
  final Color color;

  const TopicCard({
    super.key,
    required this.title,
    required this.phrases,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.2),
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 10),
            ...phrases.map((phrase) => Text('• $phrase', style: const TextStyle(fontSize: 16))),
          ],
        ),
      ),
    );
  }
}

// === Phrase Data ===

List<String> _getGreetings(String lang) {
  switch (lang) {
    case 'Tamil':
      return ['காலை வணக்கம்', 'மதிய வணக்கம்', 'மாலை வணக்கம்'];
    case 'English':
      return ['Good Morning', 'Good Afternoon', 'Good Evening'];
    case 'Hindi':
      return ['सुप्रभात', 'नमस्कार (दोपहर)', 'शुभ संध्या'];
    default:
      return [];
  }
}

List<String> _getNumbers(String lang) {
  switch (lang) {
    case 'Tamil':
      return ['ஒன்று', 'இரண்டு', 'மூன்று', 'நான்கு', 'ஐந்து', 'ஆறு', 'ஏழு', 'எட்டு', 'ஒன்பது', 'பத்து'];
    case 'English':
      return ['One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'];
    case 'Hindi':
      return ['एक', 'दो', 'तीन', 'चार', 'पाँच', 'छह', 'सात', 'आठ', 'नौ', 'दस'];
    default:
      return [];
  }
}

List<String> _getBasicPhrases(String lang) {
  switch (lang) {
    case 'Tamil':
      return ['எப்படி இருக்கிறீர்கள்?', 'நான் நலமாக இருக்கிறேன்', 'உங்கள் பெயர் என்ன?', 'என் பெயர் ___', 'நன்றி', 'மன்னிக்கவும்', 'பிரியாவிடை'];
    case 'English':
      return ['How are you?', 'I am fine', 'What is your name?', 'My name is ___', 'Thank you', 'Sorry', 'Goodbye'];
    case 'Hindi':
      return ['आप कैसे हैं?', 'मैं ठीक हूँ', 'आपका नाम क्या है?', 'मेरा नाम ___ है', 'धन्यवाद', 'माफ़ कीजिए', 'अलविदा'];
    default:
      return [];
  }
}
