import 'package:flutter/material.dart';

import 'button_component.dart';

class PracticeQuizCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final ValueChanged<int>? onOptionSelected;
  final VoidCallback onNext;
  final VoidCallback? onBack;
  final String nextButtonLabel;
  final String contactEmail;
  final String contactPhone;

  static const Color _gradientStart = Color(0xFF004299);
  static const Color _gradientEnd = Color(0xFF006FFF);
  static const Color _cardBackground = Colors.white;
  static const Color _cardShadow = Color(0x14394656);
  static const Color _optionFill = Color(0xFFF5F7FA);
  static const Color _optionFillSelected = Color(0xFFE1EEFF);
  static const Color _optionBorderSelected = Color(0xFF006FFF);
  static const Color _labelPrimary = Color(0xFF1C1F2E);
  static const Color _labelSecondary = Color(0xCCFFFFFF);

  const PracticeQuizCard({
    super.key,
    this.title = 'Practice Quiz',
    required this.subtitle,
    required this.progress,
    required this.question,
    required this.options,
    this.selectedIndex,
    this.onOptionSelected,
    required this.onNext,
    this.onBack,
    this.nextButtonLabel = 'Next question',
    this.contactEmail = 'smartdrive@gmail.com',
    this.contactPhone = '+250 782 345 678',
  }) : assert(
         options.length > 1,
         'Provide at least two options for a quiz question.',
       );

  @override
  Widget build(BuildContext context) {
    final double effectiveProgress = progress.clamp(0.0, 1.0).toDouble();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [_gradientStart, _gradientEnd],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildProgressBar(effectiveProgress),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 16),
                  physics: const BouncingScrollPhysics(),
                  child: _buildQuestionCard(context),
                ),
              ),
              const SizedBox(height: 24),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBackButton(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _labelSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: onBack,
        splashRadius: 24,
      ),
    );
  }

  Widget _buildProgressBar(double effectiveProgress) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: effectiveProgress,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_gradientStart, _gradientEnd],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 360),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        decoration: BoxDecoration(
          color: _cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: _cardShadow,
              offset: Offset(0, 10),
              blurRadius: 30,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              question,
              style: const TextStyle(
                color: _labelPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            ...List.generate(options.length, (index) => _buildOption(index)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ButtonComponent(
                text: nextButtonLabel,
                type: ButtonType.secondary,
                onPressed: onNext,
                height: 56,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(int index) {
    final bool isSelected = selectedIndex == index;
    final Color fillColor = isSelected ? _optionFillSelected : _optionFill;
    final Color borderColor = isSelected
        ? _optionBorderSelected
        : Colors.transparent;

    return Padding(
      padding: EdgeInsets.only(bottom: index == options.length - 1 ? 0 : 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onOptionSelected != null
              ? () => onOptionSelected!(index)
              : null,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 1.5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08000000),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${String.fromCharCode(65 + index)})',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? _optionBorderSelected
                        : const Color(0xFF2E3345),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    options[index],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: _labelPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          contactEmail,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          contactPhone,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
