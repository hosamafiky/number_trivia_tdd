import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/use_cases/get_concrete_number_trivia_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late GetConcreteNumberTriviaUsecase usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTriviaUsecase(mockNumberTriviaRepository);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  /// Test case for the get_number_trivia_usecase.
  ///
  /// This test case verifies the behavior of the get_number_trivia_usecase.
  /// It ensures that the use case returns the expected result when called.
  /// The test is asynchronous and uses the `async` keyword.
  ///
  /// Test case name: 'should get trivia for the number from the repository'
  /// Test case function signature: `() async {}`
  /// Test case file path: /Users/hussam/Desktop/number_trivia_tdd/test/features/number_trivia/domain/use_cases/get_number_trivia_usecase_test.dart
  test(
    'should get trivia for the number from the repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => const Right(tNumberTrivia));
      // act
      final result = await usecase(const Params(number: tNumber));
      // assert
      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
