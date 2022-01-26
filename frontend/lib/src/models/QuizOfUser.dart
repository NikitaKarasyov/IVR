import 'dart:ffi';

class QuizOfUser {
  int id;
  int quiz_id;
  int user_id;

  QuizOfUser({required this.quiz_id, required this.user_id, required this.id});
}
