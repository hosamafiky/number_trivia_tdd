import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:number_trivia_tdd/core/platform/network_info.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

@GenerateMocks([
  NumberTriviaRepository,
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpCient),
])
void main() {}
