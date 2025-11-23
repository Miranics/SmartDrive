class Question {
  final String question;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

final List<Question> mockTestQuestions = [
  Question(
    question: 'What is the maximum speed limit in residential areas in Rwanda?',
    options: [
      'A) 60 km/h',
      'B) 30 km/h',
      'C) 50 km/h',
      'D) 40 km/h',
    ],
    correctAnswer: 'D) 40 km/h',
  ),
  Question(
    question: 'When must you use your headlights while driving?',
    options: [
      'A) Only at night',
      'B) During rain, fog, or poor visibility',
      'C) Only in tunnels',
      'D) Never during the day',
    ],
    correctAnswer: 'B) During rain, fog, or poor visibility',
  ),
  Question(
    question: 'What does a red traffic light mean?',
    options: [
      'A) Slow down and proceed with caution',
      'B) Stop completely',
      'C) Speed up to clear the intersection',
      'D) Yield to oncoming traffic',
    ],
    correctAnswer: 'B) Stop completely',
  ),
  Question(
    question: 'What should you do when approaching a zebra crossing with pedestrians?',
    options: [
      'A) Speed up to pass before them',
      'B) Honk to warn them',
      'C) Stop and give them right of way',
      'D) Slow down but continue',
    ],
    correctAnswer: 'C) Stop and give them right of way',
  ),
  Question(
    question: 'What is the legal blood alcohol limit for drivers in Rwanda?',
    options: [
      'A) 0.08%',
      'B) 0.05%',
      'C) 0.00% (Zero tolerance)',
      'D) 0.02%',
    ],
    correctAnswer: 'C) 0.00% (Zero tolerance)',
  ),
  Question(
    question: 'When should you use your turn signal?',
    options: [
      'A) Only when turning left',
      'B) At least 30 meters before turning',
      'C) Only in heavy traffic',
      'D) After you start turning',
    ],
    correctAnswer: 'B) At least 30 meters before turning',
  ),
  Question(
    question: 'What does a yellow traffic light mean?',
    options: [
      'A) Speed up to clear the intersection',
      'B) Stop if safe to do so',
      'C) Continue at the same speed',
      'D) Honk before proceeding',
    ],
    correctAnswer: 'B) Stop if safe to do so',
  ),
  Question(
    question: 'What is the minimum following distance you should maintain?',
    options: [
      'A) 1 second',
      'B) 2 seconds',
      'C) 3 seconds',
      'D) 5 seconds',
    ],
    correctAnswer: 'C) 3 seconds',
  ),
  Question(
    question: 'When parking on a hill, which way should you turn your wheels?',
    options: [
      'A) Away from the curb',
      'B) Towards the curb',
      'C) Straight ahead',
      'D) It doesn\'t matter',
    ],
    correctAnswer: 'B) Towards the curb',
  ),
  Question(
    question: 'What should you do when you hear an emergency vehicle siren?',
    options: [
      'A) Speed up to get out of the way',
      'B) Stop immediately in your lane',
      'C) Pull over to the right and stop',
      'D) Continue driving normally',
    ],
    correctAnswer: 'C) Pull over to the right and stop',
  ),
  Question(
    question: 'What does a stop sign require you to do?',
    options: [
      'A) Slow down and proceed',
      'B) Stop completely at the line',
      'C) Yield to traffic',
      'D) Stop only if traffic is present',
    ],
    correctAnswer: 'B) Stop completely at the line',
  ),
  Question(
    question: 'When is it safe to overtake another vehicle?',
    options: [
      'A) On a curve',
      'B) At an intersection',
      'C) On a straight road with clear visibility',
      'D) In a school zone',
    ],
    correctAnswer: 'C) On a straight road with clear visibility',
  ),
  Question(
    question: 'What should you do if your brakes fail while driving?',
    options: [
      'A) Pump the brake pedal',
      'B) Turn off the engine immediately',
      'C) Jump out of the car',
      'D) Speed up',
    ],
    correctAnswer: 'A) Pump the brake pedal',
  ),
  Question(
    question: 'What is the purpose of the handbrake?',
    options: [
      'A) To park the vehicle',
      'B) To slow down in traffic',
      'C) To make sharp turns',
      'D) To increase speed',
    ],
    correctAnswer: 'A) To park the vehicle',
  ),
  Question(
    question: 'When should you check your mirrors?',
    options: [
      'A) Only when changing lanes',
      'B) Every 5-8 seconds',
      'C) Only when reversing',
      'D) Once every minute',
    ],
    correctAnswer: 'B) Every 5-8 seconds',
  ),
  Question(
    question: 'What does a circular blue sign with a white arrow mean?',
    options: [
      'A) No entry',
      'B) Mandatory direction',
      'C) Speed limit',
      'D) Parking allowed',
    ],
    correctAnswer: 'B) Mandatory direction',
  ),
  Question(
    question: 'What should you do at a roundabout?',
    options: [
      'A) Enter without yielding',
      'B) Yield to traffic already in the roundabout',
      'C) Stop in the middle',
      'D) Drive counterclockwise',
    ],
    correctAnswer: 'B) Yield to traffic already in the roundabout',
  ),
  Question(
    question: 'When is it illegal to use your horn?',
    options: [
      'A) In residential areas at night',
      'B) Near hospitals',
      'C) Both A and B',
      'D) Never illegal',
    ],
    correctAnswer: 'C) Both A and B',
  ),
  Question(
    question: 'What is the maximum speed on highways in Rwanda?',
    options: [
      'A) 80 km/h',
      'B) 100 km/h',
      'C) 120 km/h',
      'D) 60 km/h',
    ],
    correctAnswer: 'A) 80 km/h',
  ),
  Question(
    question: 'What should you do when approaching a school zone?',
    options: [
      'A) Maintain normal speed',
      'B) Reduce speed and watch for children',
      'C) Honk to warn children',
      'D) Speed up to pass quickly',
    ],
    correctAnswer: 'B) Reduce speed and watch for children',
  ),
];