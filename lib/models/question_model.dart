class QuestionModel {
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;

  QuestionModel({
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
  });

  QuestionModel copyWith({
    String? question,
    String? answer1,
    String? answer2,
    String? answer3,
    String? answer4,
  }) {
    return QuestionModel(
      question: question ?? this.question,
      answer1: answer1 ?? this.answer1,
      answer2: answer2 ?? this.answer2,
      answer3: answer3 ?? this.answer3,
      answer4: answer4 ?? this.answer4,
    );
  }
}
