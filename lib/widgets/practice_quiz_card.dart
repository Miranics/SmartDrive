import 'package:flutter/material.dart';

class PracticeQuizCard extends StatelessWidget {
  final String questionText;
  final List<String> options;
  final String? imageAssetPath;
  final Function(int index) onOptionSelected;
  final int? selectedIndex;
  final int? correctIndex;
  final bool enableSelection;

  const PracticeQuizCard({
    super.key,
    required this.questionText,
    required this.options,
    required this.onOptionSelected,
    this.imageAssetPath,
    this.selectedIndex,
    this.correctIndex,
    this.enableSelection = true,
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
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1A1A2E)
          : Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1A1A2E)
                  : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              questionText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                ...options.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final optionText = entry.value;
                  final label = String.fromCharCode(65 + idx);
                  return _buildOptionTile(
                    context,
                    label,
                    optionText,
                    idx,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context,
    String label,
    String text,
    int index,
  ) {
    final hasSelection = selectedIndex != null;
    final isSelected = hasSelection && selectedIndex == index;
    final isCorrect = correctIndex != null && correctIndex == index;

    Color borderColor = Colors.grey.shade300;
    List<Color> gradientColors;
    Color textColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;

    if (hasSelection && isCorrect) {
      gradientColors = [const Color(0xFF0F9D58), const Color(0xFF34A853)];
      borderColor = const Color(0xFF0F9D58);
      textColor = Colors.white;
    } else if (hasSelection && isSelected && !isCorrect) {
      gradientColors = [const Color(0xFFEA4335), const Color(0xFFC5221F)];
      borderColor = const Color(0xFFEA4335);
      textColor = Colors.white;
    } else {
      gradientColors = Theme.of(context).brightness == Brightness.dark
          ? [const Color(0xFF1A1A2E), const Color(0xFF0F3460)]
          : [const Color(0xFFFFFFFF), const Color(0xFFFDF6F6)];
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: enableSelection ? () => onOptionSelected(index) : null,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: hasSelection ? 1.5 : 1),
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
                    color: hasSelection ? Colors.white : Colors.blueGrey[700],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
