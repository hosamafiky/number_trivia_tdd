import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/core/error/exceptions.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<http.Client>(as: #MockHttpClient, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late MockHttpClient mockHttpClient;
  late NumberTriviaRemoteDataSourceImpl dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(mockHttpClient);
  });

  group(
    'getConcreteNumberTrivia',
    () {
      const tNumber = 1;
      final tNumberTriviaRes = fixture('trivia.json');
      final numberTrivia = NumberTriviaModel.fromJson(tNumberTriviaRes);
      test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
          // arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(tNumberTriviaRes, 200));
          // act
          dataSource.getConcreteNumberTrivia(tNumber);
          // assert
          verify(mockHttpClient.get(
            Uri.parse('http://numbersapi.com/$tNumber'),
            headers: {'Content-Type': 'application/json'},
          ));
        },
      );

      test(
        'should return NumberTrivia when the response code is 200 (success)',
        () async {
          // arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(tNumberTriviaRes, 200));
          // act
          final result = await dataSource.getConcreteNumberTrivia(tNumber);
          // assert
          expect(result, equals(numberTrivia));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('Something went wrong', 404));
          // act
          final call = dataSource.getConcreteNumberTrivia;
          // assert
          expect(() => call(tNumber), throwsA(isA<ServerException>()));
        },
      );
    },
  );

  group(
    'getRandomNumberTrivia',
    () {
      final tNumberTriviaRes = fixture('trivia.json');
      final numberTrivia = NumberTriviaModel.fromJson(tNumberTriviaRes);
      test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
          // arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(tNumberTriviaRes, 200));
          // act
          dataSource.getRandomNumberTrivia();
          // assert
          verify(mockHttpClient.get(
            Uri.parse('http://numbersapi.com/random'),
            headers: {'Content-Type': 'application/json'},
          ));
        },
      );

      test(
        'should return NumberTrivia when the response code is 200 (success)',
        () async {
          // arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(tNumberTriviaRes, 200));
          // act
          final result = await dataSource.getRandomNumberTrivia();
          // assert
          expect(result, equals(numberTrivia));
        },
      );

      test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
          // arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('Something went wrong', 404));
          // act
          final call = dataSource.getRandomNumberTrivia;
          // assert
          expect(() => call(), throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
