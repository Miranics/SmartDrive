import 'package:flutter/material.dart';
import 'package:smartdrive/constants/app_colors.dart';
import 'package:smartdrive/widgets/page_header.dart';
import 'package:smartdrive/widgets/contact_us_card.dart';
import 'package:smartdrive/widgets/tips_card_component.dart';

class PracticalTipsPage extends StatelessWidget {
  const PracticalTipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            PageHeader(
              title: 'Practical Tips',
              subtitle: 'Expert advice for your driving test',
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TipsCard(
                    title: 'Cones Exam',
                    description:
                        'This first part of the practical driving exam is simple, but requires keen attention to surroundings.',
                    iconPath: 'assets/icons/cones.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TipsDetailPage(
                            title: 'Cones Exam',
                            tips: [
                              'Drive slowly and carefully through the cones',
                              'Keep your eyes on the path ahead',
                              'Maintain steady speed and smooth steering',
                              'Don\'t rush - accuracy is more important than speed',
                              'Practice makes perfect - the more you do it, the easier it gets',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  TipsCard(
                    title: 'Parallel Parking Exam',
                    description:
                        'Practice this maneuver early to gain confidence. Remember the key points and take your time, however it has a 2 minute time limit.',
                    iconPath: 'assets/icons/parking.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TipsDetailPage(
                            title: 'Parallel Parking Exam',
                            tips: [
                              'Position your car parallel to the vehicle in front',
                              'Turn the wheel fully to the right and reverse slowly',
                              'When your car is at 45 degrees, straighten the wheel',
                              'Continue reversing until your car is parallel',
                              'Complete the maneuver within 2 minutes',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  TipsCard(
                    title: 'Circulation Exam',
                    description:
                        'Time to hit the road! You must remain calm and follow what the instructor tells you to do, but watch out for the trick questions!',
                    iconPath: 'assets/icons/circulation.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TipsDetailPage(
                            title: 'Circulation Exam',
                            tips: [
                              'Follow all traffic rules and road signs',
                              'Listen carefully to the examiner\'s instructions',
                              'Check mirrors frequently - every 5-8 seconds',
                              'Use turn signals well in advance',
                              'Maintain safe following distance',
                              'Be aware of trick questions from the examiner',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  TipsCard(
                    title: 'T - Cross Exam',
                    description:
                        'Always check your mirrors and blind spots, and don\'t forget to signal. Take your time, but be aware of the traffic while reversing.',
                    iconPath: 'assets/icons/t_cross.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TipsDetailPage(
                            title: 'T - Cross Exam',
                            tips: [
                              'Check all mirrors before starting the maneuver',
                              'Always check blind spots by looking over your shoulder',
                              'Use your turn signals to indicate your intentions',
                              'Reverse slowly and carefully',
                              'Be aware of other traffic and pedestrians',
                              'Take your time but don\'t hold up traffic unnecessarily',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  TipsCard(
                    title: 'Demerage Exam',
                    description:
                        'The final part of the exam where your control of the car is tested on a steep hill. Remain calm, listen to the car and the instructors signal.',
                    iconPath: 'assets/icons/demerage.png',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TipsDetailPage(
                            title: 'Demerage Exam',
                            tips: [
                              'Use the handbrake to prevent rolling backwards',
                              'Find the biting point before releasing the handbrake',
                              'Give more gas than usual on steep hills',
                              'Listen to the engine - it will tell you when it\'s ready',
                              'Stay calm and don\'t rush',
                              'Practice hill starts in different conditions',
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const ContactUsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TipsDetailPage extends StatelessWidget {
  final String title;
  final List<String> tips;

  const TipsDetailPage({
    super.key,
    required this.title,
    required this.tips,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          PageHeader(
            title: title,
            subtitle: 'Tips and advice',
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(tips.length, (index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? const Color(0xFF1A1A2E)
                        : AppColors.paleBlue,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryBlue,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryBlue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          tips[index],
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          const ContactUsCard(),
        ],
      ),
    );
  }
}
