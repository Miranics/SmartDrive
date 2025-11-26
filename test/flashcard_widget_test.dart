import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartdrive/screens/flashcard.dart';

void main() {
  // Helper to create the widget with Material wrapper
  Widget createWidgetForTesting({required Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Flashcard UI Test: Tapping button shows answer', (WidgetTester tester) async {
    // 1. Build the FlashcardPage
    await tester.pumpWidget(createWidgetForTesting(child: const FlashcardPage()));

    // 2. Verify the initial question is visible
    expect(find.text('What does this traffic sign mean?'), findsOneWidget);
    
    // Verify answer is HIDDEN initially
    expect(find.text('No Entry - Vehicles are not allowed to enter this road.'), findsNothing);
    
    // Find the button
    final buttonFinder = find.text('Show Answer');
    expect(buttonFinder, findsOneWidget);

    // --- FIX IS HERE ---
    // Ensure the button is visible (scrolls down if needed)
    await tester.ensureVisible(buttonFinder);
    await tester.pumpAndSettle(); // Wait for the scroll animation to finish
    // -------------------

    // 3. Simulate a USER TAP on the "Show Answer" button
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle(); // Rebuild the UI after the tap

    // 4. Verify the ANSWER is now visible
    expect(find.text('No Entry - Vehicles are not allowed to enter this road.'), findsOneWidget);
    
    // Verify button text changed
    expect(find.text('Hide Answer'), findsOneWidget);
  });
}