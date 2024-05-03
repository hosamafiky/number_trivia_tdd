import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test text');

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      // assert
      expect(tNumberTriviaModel, isA<NumberTriviaModel>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON number is an integer',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
          // act
          final result = NumberTriviaModel.fromMap(jsonMap);
          // assert
          expect(result, tNumberTriviaModel);
        },
      );

      test(
        'should return a valid model when the JSON is String',
        () async {
          // arrange
          final String jsonContent = fixture('trivia_double.json');
          // act
          final result = NumberTriviaModel.fromJson(jsonContent);
          // assert
          expect(result, tNumberTriviaModel);
        },
      );

      test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
          // arrange
          final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));
          // act
          final result = NumberTriviaModel.fromMap(jsonMap);
          // assert
          expect(result, tNumberTriviaModel);
        },
      );
    },
  );

  group(
    'toMap',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          // arrange
          final result = tNumberTriviaModel.toMap();
          // act
          final expectedMap = json.decode(fixture('trivia_cached.json'));
          // assert
          expect(result, expectedMap);
        },
      );

      test(
        'should return a String data contains the proper data',
        () async {
          // arrange
          final result = tNumberTriviaModel.toJson();
          // act
          final expectedMap = json.encode(json.decode(fixture('trivia_cached.json')));
          // assert
          expect(result, expectedMap);
        },
      );
    },
  );
}
