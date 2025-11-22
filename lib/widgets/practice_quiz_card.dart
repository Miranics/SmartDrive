import 'package:flutter/material.dart';

class PracticeQuizCard extends StatelessWidget {
  final String questionText;
  final List<String> options;
  final String? imageAssetPath;
  final Function(int index) onOptionSelected;

  const PracticeQuizCard({
    super.key,
    required this.questionText,
    required this.options,
    required this.onOptionSelected,
    this.imageAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      // 1. Set Main Card color to white
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- 1. THE QUESTION SECTION ---
          // I changed this to White to match "background of the whole thing becomes white"
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white, // Changed from blueGrey[50] to white
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              questionText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Content padding for Image and Options
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // --- 2. THE OPTIMIZED IMAGE SECTION ---
                if (imageAssetPath != null) ...[
                  Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(imageAssetPath!, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // --- 3. The Options ---
                ...options.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String optionText = entry.value;
                  String label = String.fromCharCode(65 + idx);
                  return _buildOptionTile(label, optionText, idx);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(String label, String text, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => onOptionSelected(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            // 2. THIS IS WHERE THE GRADIENT GOES
            // Replaced solid color with the gradient you requested
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFFFFF), // #FFFFFF (white)
                Color(0xFFFDF6F6), // #FDF6F6 (light pink/beige)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Container(
                width: 30,
                alignment: Alignment.center,
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[700],
                  ),
                ),
              ),
              Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
            ],
          ),
        ),
      ),
    );
  }
}
