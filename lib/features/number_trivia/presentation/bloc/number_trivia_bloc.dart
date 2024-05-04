// ignore_for_file: constant_identifier_names

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia_tdd/core/error/failures.dart';

import '../../../../core/utils/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/use_cases/get_concrete_number_trivia_usecase.dart';
import '../../domain/use_cases/get_random_number_trivia_usecase.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE = 'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTriviaUsecase getConcreteNumberTriviaUsecase;
  final GetRandomNumberTriviaUsecase getRandomNumberTriviaUsecase;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTriviaUsecase,
    required this.getRandomNumberTriviaUsecase,
    required this.inputConverter,
  }) : super(EmptyState()) {
    on<NumberTriviaEvent>((event, emit) async {
      mapFailureToMessage(Failure failure) {
        if (failure is ServerFailure) {
          return SERVER_FAILURE_MESSAGE;
        } else if (failure is CacheFailure) {
          return CACHE_FAILURE_MESSAGE;
        } else if (failure is InvalidInputFailure) {
          return INVALID_INPUT_FAILURE_MESSAGE;
        } else {
          return 'Unexpected Error';
        }
      }

      Future<void> emitErrorOrTrivia(Either<Failure, NumberTrivia> either) async {
        either.fold(
          (failure) => emit(ErrorState(message: mapFailureToMessage(failure))),
          (trivia) => emit(LoadedState(trivia: trivia)),
        );
      }

      if (event is GetTriviaForConcreteNumberEvent) {
        final inputEither = inputConverter.stringToUnsignedInteger(event.numberString);
        inputEither.fold(
          (failure) => emit(const ErrorState(message: INVALID_INPUT_FAILURE_MESSAGE)),
          (parsedInput) async {
            emit(LoadingState());
            final triviaEither = await getConcreteNumberTriviaUsecase(Params(number: parsedInput));
            emitErrorOrTrivia(triviaEither);
          },
        );
      }

      if (event is GetTriviaForRandomNumberEvent) {
        emit(LoadingState());
        final triviaEither = await getRandomNumberTriviaUsecase(NoParams());
        emitErrorOrTrivia(triviaEither);
      }
    });
  }
}
