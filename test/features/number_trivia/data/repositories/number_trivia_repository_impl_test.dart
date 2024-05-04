import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/core/error/exceptions.dart';
import 'package:number_trivia_tdd/core/error/failures.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia_tdd/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../helper/test_helper.mocks.dart';

void main() {
  late NumberTriviaRepositoryImpl repository;
  late MockNumberTriviaLocalDataSource localDataSource;
  late MockNumberTriviaRemoteDataSource remoteDataSource;
  late MockNetworkInfo networkInfo;

  setUp(() {
    localDataSource = MockNumberTriviaLocalDataSource();
    remoteDataSource = MockNumberTriviaRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  });

  void runTestsOnline(VoidCallback runTests) {
    group('device is online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      runTests();
    });
  }

  void runTestsOffline(VoidCallback runTests) {
    group('device is offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      runTests();
    });
  }

  group(
    'getConcreteNumberTrivia',
    () {
      const tNumber = 1;
      const tNumberTriviaModel = NumberTriviaModel(text: 'test', number: 1);
      const NumberTrivia tNumberTrivia = tNumberTriviaModel;

      test(
        'should check if device is Online',
        () async {
          // ARRANGE
          when(networkInfo.isConnected).thenAnswer((_) async => true);

          // ACT
          final result = await networkInfo.isConnected;

          // ASSERT
          expect(result, true);
          verify(networkInfo.isConnected);
        },
      );

      runTestsOnline(
        () {
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              // ARRANGE
              when(remoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);

              // ACT
              final result = await repository.getConcreteNumberTrivia(tNumber);

              // ASSERT
              expect(result, equals(const Right(tNumberTrivia)));
              verify(repository.getConcreteNumberTrivia(tNumber));
            },
          );

          test(
            'should cache the data locally when the call to remote data source is successful',
            () async {
              // ARRANGE
              when(remoteDataSource.getConcreteNumberTrivia(tNumber)).thenAnswer((_) async => tNumberTriviaModel);

              // ACT
              await repository.getConcreteNumberTrivia(tNumber);

              // ASSERT
              verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
              verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
            },
          );

          test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
              // ARRANGE
              when(remoteDataSource.getConcreteNumberTrivia(tNumber)).thenThrow(ServerException());

              // ACT
              final result = await repository.getConcreteNumberTrivia(tNumber);

              // ASSERT
              verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
              verifyZeroInteractions(localDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(
        () {
          test(
            'should return last locally cached data when the cached data is present',
            () async {
              // ARRANGE
              when(localDataSource.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

              // ACT
              final result = await localDataSource.getLastNumberTrivia();

              // ASSERT
              expect(result, tNumberTrivia);
              verify(localDataSource.getLastNumberTrivia());
            },
          );

          test(
            'should return CacheFailure when there is no cached data present',
            () async {
              // ARRANGE
              when(localDataSource.getLastNumberTrivia()).thenThrow(NoLocalDataException());

              // ACT
              final result = await repository.getConcreteNumberTrivia(tNumber);

              // ASSERT
              verifyZeroInteractions(remoteDataSource);
              verify(localDataSource.getLastNumberTrivia());
              expect(result, equals(Left(CacheFailure())));
            },
          );
        },
      );
    },
  );

  group(
    'getRandomNumberTrivia',
    () {
      const tNumberTriviaModel = NumberTriviaModel(text: 'test', number: 1);
      const NumberTrivia tNumberTrivia = tNumberTriviaModel;

      test(
        'should check if device is Online',
        () async {
          // ARRANGE
          when(networkInfo.isConnected).thenAnswer((_) async => true);

          // ACT
          repository.getRandomNumberTrivia();

          // ASSERT
          verify(networkInfo.isConnected);
        },
      );

      runTestsOnline(
        () {
          test(
            'should return remote data when the call to remote data source is successful',
            () async {
              // ARRANGE
              when(remoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

              // ACT
              final result = await repository.getRandomNumberTrivia();

              // ASSERT
              expect(result, equals(const Right(tNumberTrivia)));
              verify(remoteDataSource.getRandomNumberTrivia());
            },
          );

          test(
            'should cache the data locally when the call to remote data source is successful',
            () async {
              // ARRANGE
              when(remoteDataSource.getRandomNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

              // ACT
              await repository.getRandomNumberTrivia();

              // ASSERT
              verify(remoteDataSource.getRandomNumberTrivia());
              verify(localDataSource.cacheNumberTrivia(tNumberTriviaModel));
            },
          );

          test(
            'should return server failure when the call to remote data source is unsuccessful',
            () async {
              // ARRANGE
              when(remoteDataSource.getRandomNumberTrivia()).thenThrow(ServerException());

              // ACT
              final result = await repository.getRandomNumberTrivia();

              // ASSERT
              verify(remoteDataSource.getRandomNumberTrivia());
              verifyZeroInteractions(localDataSource);
              expect(result, equals(Left(ServerFailure())));
            },
          );
        },
      );

      runTestsOffline(() {
        test(
          'should return last locally cached data when the cached data is present',
          () async {
            // ARRANGE
            when(localDataSource.getLastNumberTrivia()).thenAnswer((_) async => tNumberTriviaModel);

            // ACT
            final result = await localDataSource.getLastNumberTrivia();

            // ASSERT
            expect(result, tNumberTrivia);
            verify(localDataSource.getLastNumberTrivia());
          },
        );

        test(
          'should return CacheFailure when there is no cached data present',
          () async {
            // ARRANGE
            when(localDataSource.getLastNumberTrivia()).thenThrow(NoLocalDataException());

            // ACT
            final result = await repository.getRandomNumberTrivia();

            // ASSERT
            verifyZeroInteractions(remoteDataSource);
            verify(localDataSource.getLastNumberTrivia());
            expect(result, equals(Left(CacheFailure())));
          },
        );
      });
    },
  );
}
