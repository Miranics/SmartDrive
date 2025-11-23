import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartdrive/widgets/button_component.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/contact_us_card.dart'; 
import 'package:smartdrive/constants/app_colors.dart';

class FlashcardPage extends StatefulWidget {
  // Fixed: Use super.key for cleaner code
  const FlashcardPage({super.key});

  @override
  State<FlashcardPage> createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  bool _showAnswer = false;
  int _currentIndex = 0;

  final List<Map<String, String>> _flashcards = [
    {
      'question': 'What does this traffic sign mean?',
      'answer': 'No Entry - This sign prohibits vehicles from entering a road or area.',
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

  @override
  Widget build(BuildContext context) {
    final currentCard = _flashcards[_currentIndex];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
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
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            // Fixed: Replace withOpacity with withValues(alpha: ...)
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red[700],
                              border: Border.all(
                                color: Colors.red[900]!,
                                width: 8,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 160,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          Text(
                            currentCard['question']!,
                            // Fixed: Added GoogleFonts style or kept standard
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          
                          if (_showAnswer) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                currentCard['answer']!,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],

                          ButtonComponent(
                            text: _showAnswer ? 'Hide Answer' : 'Show Answer',
                            type: ButtonType.primary,
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
                            type: ButtonType.outlined,
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
                ],
              ),
            ),
          ),
          // Fixed: Changed 'ContactFooter' to 'ContactUsCard' to match your import.
          const ContactUsCard(),
        ],
      ),
    );
  }
}