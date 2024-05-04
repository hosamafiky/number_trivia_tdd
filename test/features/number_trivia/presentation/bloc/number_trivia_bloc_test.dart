import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/core/error/failures.dart';
import 'package:number_trivia_tdd/core/utils/input_converter.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/use_cases/get_concrete_number_trivia_usecase.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/use_cases/get_random_number_trivia_usecase.dart';
import 'package:number_trivia_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<InputConverter>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetConcreteNumberTriviaUsecase>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetRandomNumberTriviaUsecase>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late NumberTriviaBloc bloc;
  late MockInputConverter inputConverter;
  late MockGetConcreteNumberTriviaUsecase mockGetConcreteNumberTriviaUsecase;
  late MockGetRandomNumberTriviaUsecase mockGetRandomNumberTriviaUsecase;

  setUp(() {
    inputConverter = MockInputConverter();
    mockGetConcreteNumberTriviaUsecase = MockGetConcreteNumberTriviaUsecase();
    mockGetRandomNumberTriviaUsecase = MockGetRandomNumberTriviaUsecase();
    bloc = NumberTriviaBloc(
      getConcreteNumberTriviaUsecase: mockGetConcreteNumberTriviaUsecase,
      getRandomNumberTriviaUsecase: mockGetRandomNumberTriviaUsecase,
      inputConverter: inputConverter,
    );
  });

  test('initialState should be EmptyState', () {
    // assert
    expect(bloc.state, equals(EmptyState()));
  });

  group(
    'Get Concrete Number Trivia',
    () {
      const tNumberString = '1';
      const tNumberParsed = 1;
      const tNumberTrivia = NumberTrivia(text: 'test', number: 1);

      void setUpMockInputConverterSuccess() {
        when(inputConverter.stringToUnsignedInteger(tNumberString)).thenAnswer((_) => const Right(tNumberParsed));
      }

      void setUpMockInputConverterFailure() {
        when(inputConverter.stringToUnsignedInteger(tNumberString)).thenAnswer((_) => Left(InvalidInputFailure()));
      }

      test(
        'should use Input Converter to validate and convert the string to an unsigned integer',
        () async {
          // ARRANGE
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTriviaUsecase(const Params(number: tNumberParsed))).thenAnswer((_) async => const Right(tNumberTrivia));
          // ACT
          bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
          await untilCalled(inputConverter.stringToUnsignedInteger(tNumberString));

          // ASSERT
          verify(inputConverter.stringToUnsignedInteger(tNumberString));
        },
      );

      test(
        'should emit [ErrorState] when the input is invalid',
        () async {
          // ARRANGE
          setUpMockInputConverterFailure();

          // ASSERT LATER
          final expected = [
            const ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));

          // ACT
          bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
        },
      );

      test(
        'should get data from the concrete use case',
        () async {
          // ARRANGE
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTriviaUsecase(const Params(number: tNumberParsed))).thenAnswer((_) async => const Right(tNumberTrivia));

          // ACT
          bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
          await untilCalled(mockGetConcreteNumberTriviaUsecase(const Params(number: tNumberParsed)));

          // ASSERT
          verify(mockGetConcreteNumberTriviaUsecase(const Params(number: tNumberParsed)));
        },
      );

      test(
        'should emit [LoadingState, LoadedState] when data is gotten successfully',
        () async {
          // ARRANGE
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTriviaUsecase(const Params(number: tNumberParsed))).thenAnswer((_) async => const Right(tNumberTrivia));

          // ASSERT LATER
          final expected = [
            LoadingState(),
            const LoadedState(trivia: tNumberTrivia),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));

          // ACT
          bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
        },
      );

      test(
        'should emit [LoadingState, ErrorState] when getting data fails',
        () async {
          // ARRANGE
          setUpMockInputConverterSuccess();
          when(mockGetConcreteNumberTriviaUsecase(const Params(number: tNumberParsed))).thenAnswer((_) async => Left(ServerFailure()));

          // ASSERT LATER
          final expected = [
            LoadingState(),
            const ErrorState(message: SERVER_FAILURE_MESSAGE),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));

          // ACT
          bloc.add(const GetTriviaForConcreteNumberEvent(tNumberString));
        },
      );
    },
  );

  group(
    'Get Random Number Trivia',
    () {
      const tNumberTrivia = NumberTrivia(text: 'test', number: 1);

      test(
        'should get data from the random use case',
        () async {
          // ARRANGE
          when(mockGetRandomNumberTriviaUsecase(NoParams())).thenAnswer((_) async => const Right(tNumberTrivia));

          // ACT
          bloc.add(GetTriviaForRandomNumberEvent());
          await untilCalled(mockGetRandomNumberTriviaUsecase(NoParams()));

          // ASSERT
          verify(mockGetRandomNumberTriviaUsecase(NoParams()));
        },
      );

      test(
        'should emit [LoadingState, LoadedState] when data is gotten successfully',
        () async {
          // ARRANGE
          when(mockGetRandomNumberTriviaUsecase(NoParams())).thenAnswer((_) async => const Right(tNumberTrivia));

          // ASSERT LATER
          final expected = [
            LoadingState(),
            const LoadedState(trivia: tNumberTrivia),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));

          // ACT
          bloc.add(GetTriviaForRandomNumberEvent());
        },
      );

      test(
        'should emit [LoadingState, ErrorState] when getting data fails',
        () async {
          // ARRANGE
          when(mockGetRandomNumberTriviaUsecase(NoParams())).thenAnswer((_) async => Left(ServerFailure()));

          // ASSERT LATER
          final expected = [
            LoadingState(),
            const ErrorState(message: SERVER_FAILURE_MESSAGE),
          ];
          expectLater(bloc.stream, emitsInOrder(expected));

          // ACT
          bloc.add(GetTriviaForRandomNumberEvent());
        },
      );
    },
  );
}
