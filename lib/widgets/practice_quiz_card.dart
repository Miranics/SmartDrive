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
      elevation: 0, // Removed shadow for a flatter, cleaner look
      // Adding a border to make it pop against the white background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      color: Colors.white, // Card background matches the white theme
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // --- 1. THE QUESTION SECTION (With its own background) ---
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors
                  .blueGrey[50], // <--- The specific "Question Background"
              borderRadius: const BorderRadius.only(
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
                    // Limit the height so it doesn't take too much space
                    constraints: const BoxConstraints(
                      maxHeight: 200, // Max height is 200 pixels
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imageAssetPath!,
                        // 'contain' ensures the WHOLE image is seen inside the
                        // 200px height box, adding whitespace on sides if needed.
                        fit: BoxFit.contain,
                      ),
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            // A nice clear border for the options
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
