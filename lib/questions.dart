class Question{
  String questionText = '';
  bool answerText  = true;

  Question({ String? q, bool? a}) {
    questionText = q!;
    answerText = a!;
  }
}