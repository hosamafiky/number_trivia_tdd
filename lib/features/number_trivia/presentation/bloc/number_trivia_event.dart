part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class ValidateUserInputEvent extends NumberTriviaEvent {
  final String inputString;

  const ValidateUserInputEvent(this.inputString);

  @override
  List<Object> get props => [inputString];
}

class GetTriviaForConcreteNumberEvent extends NumberTriviaEvent {
  final int number;

  const GetTriviaForConcreteNumberEvent(this.number);

  @override
  List<Object> get props => [number];
}

class GetTriviaForRandomNumberEvent extends NumberTriviaEvent {}
