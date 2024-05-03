import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'number_trivia_state.dart';

class NumberTriviaCubit extends Cubit<NumberTriviaState> {
  NumberTriviaCubit() : super(NumberTriviaInitial());
}
