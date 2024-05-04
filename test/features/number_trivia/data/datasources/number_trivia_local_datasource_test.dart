import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/core/error/exceptions.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_local_datasource_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SharedPreferences>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late NumberTriviaLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(mockSharedPreferences);
  });

  group(
    'getLastNumberTrivia',
    () {
      final tNumberTriviaModel = NumberTriviaModel.fromJson(fixture('trivia_cached.json'));
      final NumberTriviaModel tNumberTrivia = tNumberTriviaModel;
      test(
        'should return NumberTrivia from SharedPreferences when there is one in the cache',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any)).thenReturn(tNumberTriviaModel.toJson());
          // act
          final result = await dataSource.getLastNumberTrivia();
          // assert
          verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
          expect(result, equals(tNumberTrivia));
        },
      );

      test(
        'should throw a CacheException when there is not a cached value',
        () async {
          // arrange
          when(mockSharedPreferences.getString(any)).thenReturn(null);
          // act
          final call = dataSource.getLastNumberTrivia;
          // assert
          expect(() => call(), throwsA(isA<NoLocalDataException>()));
        },
      );
    },
  );

  group(
    'cacheNumberTrivia',
    () {
      const tNumberTriviaModel = NumberTriviaModel(text: 'test', number: 1);
      test(
        'should call SharedPreferences to cache the data',
        () async {
          // act
          await dataSource.cacheNumberTrivia(tNumberTriviaModel);
          // assert
          final expectedJsonString = tNumberTriviaModel.toJson();
          verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));
        },
      );
    },
  );
}
