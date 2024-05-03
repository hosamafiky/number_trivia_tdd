import 'dart:convert';

import '../../domain/entities/number_trivia.dart';

class NumberTriviaModel extends NumberTrivia {
  const NumberTriviaModel({
    required super.text,
    required super.number,
  });

  factory NumberTriviaModel.fromMap(Map<String, dynamic> json) {
    return NumberTriviaModel(
      text: json['text'],
      number: (json['number'] as num).toInt(),
    );
  }

  factory NumberTriviaModel.fromJson(String source) {
    return NumberTriviaModel.fromMap(json.decode(source));
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'number': number,
    };
  }

  String toJson() => json.encode(toMap());
}
