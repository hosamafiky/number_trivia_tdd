import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/use_cases/get_random_number_trivia_usecase.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late MockNumberTriviaRepositoryImpl mockNumberTriviaRepository;
  late GetRandomNumberTriviaUsecase usecase;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepositoryImpl();
    usecase = GetRandomNumberTriviaUsecase(mockNumberTriviaRepository);
  });

  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  /// Test case for the get_random_number_trivia_usecase.
  ///
  /// This test case verifies the behavior of the get_random_number_trivia_usecase.
  /// It ensures that the use case returns the expected result when called.
  /// The test is asynchronous and uses the `async` keyword.
  ///
  /// Test case name: 'should get trivia for the random number from the repository'
  /// Test case function signature: `() async {}`
  /// Test case file path: /Users/hussam/Desktop/number_trivia_tdd/test/features/number_trivia/domain/use_cases/get_random_number_trivia_usecase_test.dart
  ///
  test(
    'should get trivia for the random number from the repository',
    () async {
      // ARRANGE
      when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer((_) async => const Right(tNumberTrivia));

      // ACT
      final result = await usecase(NoParams());

      // ASSERT
      expect(result, const Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
