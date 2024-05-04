import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';

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
      test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
          // arrange
          when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('{"text": "Test Text", "number": 1}', 200));
          // act
          dataSource.getConcreteNumberTrivia(1);
          // assert
          verify(mockHttpClient.get(
            Uri.parse('http://numbersapi.com/1'),
            headers: {'Content-Type': 'application/json'},
          ));
        },
      );
    },
  );
}
