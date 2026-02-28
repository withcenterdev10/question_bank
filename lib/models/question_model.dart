class QuestionModel {
  final String? id;
  final String question;
  final String answer1;
  final String answer2;
  final String answer3;
  final String answer4;
  final String correctAnswer;

  QuestionModel({
    this.id,
    required this.question,
    required this.answer1,
    required this.answer2,
    required this.answer3,
    required this.answer4,
    required this.correctAnswer,
  });

  QuestionModel copyWith({
    String? questionId,
    String? question,
    String? answer1,
    String? answer2,
    String? answer3,
    String? answer4,
    String? correctAnswer,
  }) {
    return QuestionModel(
      id: questionId ?? this.id,
      question: question ?? this.question,
      answer1: answer1 ?? this.answer1,
      answer2: answer2 ?? this.answer2,
      answer3: answer3 ?? this.answer3,
      answer4: answer4 ?? this.answer4,
      correctAnswer: correctAnswer ?? this.correctAnswer,
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    if (json case {
      "id": final String id,
      "question": final String question,
      "answer1": final String answer1,
      "answer2": final String answer2,
      "answer3": final String answer3,
      "answer4": final String answer4,
      "correctAnswer": final String correctAnswer,
    }) {
      return QuestionModel(
        id: id,
        question: question,
        answer1: answer1,
        answer2: answer2,
        answer3: answer3,
        answer4: answer4,
        correctAnswer: correctAnswer,
      );
    } else {
      throw const FormatException(
        'Unexpected JSON format (BlogModel.fromJson)',
      );
    }
  }
}

  // factory BlogModel.fromJson(Map<String, dynamic> json) {
  //   if (json case {
  //     'id': final String id,
  //     'blog': final String blog,
  //     'title': final String title,
  //     'image_urls': final List<dynamic>? imageUrls,
  //     'created_at': final String createdAt,
  //     'user': final Map<String, dynamic> user,
  //   }) {
  //     return BlogModel(
  //       id: id,
  //       blog: blog,
  //       title: title,
  //       imageUrls: imageUrls != null
  //           ? imageUrls.map((img) => img as String).toList()
  //           : [],
  //       comments: [],
  //       createdAt: createdAt,
  //       user: BlogUserModel.formJson(user),
  //     );
    // } else {
    //   throw const FormatException(
    //     'Unexpected JSON format (BlogModel.fromJson)',
    //   );
    // }
  // }
