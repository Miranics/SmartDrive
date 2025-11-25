import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/constants/app_colors.dart';

class FlashcardPage extends StatefulWidget {
  const FlashcardPage({super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool _showAnswer = false;
  int _currentIndex = 0;

  final List<Map<String, String>> _flashcards = [
    {
      'type': 'no_entry',
      'question': 'What does this traffic sign mean?',
      'answer': 'No Entry - Vehicles are not allowed to enter this road.',
    },
    {
      'type': 'stop',
      'question': 'What action must you take at this sign?',
      'answer': 'Stop completely. Give way to all traffic before proceeding.',
    },
    {
      'type': 'speed_limit',
      'question': 'What is the maximum speed allowed here?',
      'answer': '40 km/h is the maximum legal speed limit.',
    },
    {
      'type': 'pedestrian',
      'question': 'What does this warning sign indicate?',
      'answer': 'Pedestrian Crossing - Watch out for people crossing the road.',
    },
    {
      'type': 'parking',
      'question': 'What does this blue sign indicate?',
      'answer': 'Parking Area - You are allowed to park your vehicle here.',
    },
  ];

  void _toggleAnswer() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  void _previousCard() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _showAnswer = false;
      });
    }
  }

  void _nextCard() {
    if (_currentIndex < _flashcards.length - 1) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    }
  }

  Widget _buildTrafficSign(String type) {
    switch (type) {
      case 'no_entry':
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red[700],
            border: Border.all(color: Colors.red[900]!, width: 8),
          ),
          child: Center(
            child: Container(
              width: 140,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        );
      case 'stop':
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red[700],
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2), blurRadius: 4)
            ],
          ),
          child: Center(
            child: Text(
              "STOP",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
          ),
        );
      case 'speed_limit':
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.red[700]!, width: 15),
          ),
          child: Center(
            child: Text(
              "40",
              style: GoogleFonts.inter(
                color: Colors.black,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      case 'pedestrian':
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: const Color(0xFFFFD700),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 4),
          ),
          child: const Center(
            child: Icon(Icons.directions_walk, size: 120, color: Colors.black),
          ),
        );
      case 'parking':
        return Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blue[700],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: Center(
            child: Text(
              "P",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 120,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        );
      default:
        return const SizedBox(width: 200, height: 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentCard = _flashcards[_currentIndex];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
                  PageHeader(
                    title: 'Flashcards',
                    subtitle: 'Traffic signs and rules',
                    onBackPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1A1A2E)
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildTrafficSign(currentCard['type']!),
                          const SizedBox(height: 32),
                          Text(
                            currentCard['question']!,
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          if (_showAnswer) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFF0F3460)
                                    : Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                currentCard['answer']!,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                          ButtonComponent(
                            text: _showAnswer ? 'Hide Answer' : 'Show Answer',
                            type: ButtonType.secondary,
                            onPressed: _toggleAnswer,
                            width: double.infinity,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ButtonComponent(
                            text: 'Previous',
                            type: ButtonType.small,
                            onPressed: _currentIndex > 0 ? _previousCard : null,
                            width: double.infinity,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ButtonComponent(
                            text: 'Next',
                            type: ButtonType.secondary,
                            onPressed: _currentIndex < _flashcards.length - 1
                                ? _nextCard
                                : null,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  const ContactUsCard(),
                ],
              ),
            ),
    );
  }
}
