// Mocks generated by Mockito 5.4.4 from annotations
// in number_trivia_tdd/test/helper/test_helper.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:dartz/dartz.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:number_trivia_tdd/core/error/failures.dart' as _i9;
import 'package:number_trivia_tdd/core/network/network_info.dart' as _i4;
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_local_datasource.dart'
    as _i3;
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart'
    as _i2;
import 'package:number_trivia_tdd/features/number_trivia/data/models/number_trivia_model.dart'
    as _i6;
import 'package:number_trivia_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart'
    as _i7;
import 'package:number_trivia_tdd/features/number_trivia/domain/entities/number_trivia.dart'
    as _i10;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeNumberTriviaRemoteDataSource_0 extends _i1.SmartFake
    implements _i2.NumberTriviaRemoteDataSource {
  _FakeNumberTriviaRemoteDataSource_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNumberTriviaLocalDataSource_1 extends _i1.SmartFake
    implements _i3.NumberTriviaLocalDataSource {
  _FakeNumberTriviaLocalDataSource_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNetworkInfo_2 extends _i1.SmartFake implements _i4.NetworkInfo {
  _FakeNetworkInfo_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_3<L, R> extends _i1.SmartFake implements _i5.Either<L, R> {
  _FakeEither_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeNumberTriviaModel_4 extends _i1.SmartFake
    implements _i6.NumberTriviaModel {
  _FakeNumberTriviaModel_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [NumberTriviaRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockNumberTriviaRepositoryImpl extends _i1.Mock
    implements _i7.NumberTriviaRepositoryImpl {
  @override
  _i2.NumberTriviaRemoteDataSource get remoteDataSource => (super.noSuchMethod(
        Invocation.getter(#remoteDataSource),
        returnValue: _FakeNumberTriviaRemoteDataSource_0(
          this,
          Invocation.getter(#remoteDataSource),
        ),
        returnValueForMissingStub: _FakeNumberTriviaRemoteDataSource_0(
          this,
          Invocation.getter(#remoteDataSource),
        ),
      ) as _i2.NumberTriviaRemoteDataSource);

  @override
  _i3.NumberTriviaLocalDataSource get localDataSource => (super.noSuchMethod(
        Invocation.getter(#localDataSource),
        returnValue: _FakeNumberTriviaLocalDataSource_1(
          this,
          Invocation.getter(#localDataSource),
        ),
        returnValueForMissingStub: _FakeNumberTriviaLocalDataSource_1(
          this,
          Invocation.getter(#localDataSource),
        ),
      ) as _i3.NumberTriviaLocalDataSource);

  @override
  _i4.NetworkInfo get networkInfo => (super.noSuchMethod(
        Invocation.getter(#networkInfo),
        returnValue: _FakeNetworkInfo_2(
          this,
          Invocation.getter(#networkInfo),
        ),
        returnValueForMissingStub: _FakeNetworkInfo_2(
          this,
          Invocation.getter(#networkInfo),
        ),
      ) as _i4.NetworkInfo);

  @override
  _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>
      getConcreteNumberTrivia(int? number) => (super.noSuchMethod(
            Invocation.method(
              #getConcreteNumberTrivia,
              [number],
            ),
            returnValue:
                _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>.value(
                    _FakeEither_3<_i9.Failure, _i10.NumberTrivia>(
              this,
              Invocation.method(
                #getConcreteNumberTrivia,
                [number],
              ),
            )),
            returnValueForMissingStub:
                _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>.value(
                    _FakeEither_3<_i9.Failure, _i10.NumberTrivia>(
              this,
              Invocation.method(
                #getConcreteNumberTrivia,
                [number],
              ),
            )),
          ) as _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>);

  @override
  _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>
      getRandomNumberTrivia() => (super.noSuchMethod(
            Invocation.method(
              #getRandomNumberTrivia,
              [],
            ),
            returnValue:
                _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>.value(
                    _FakeEither_3<_i9.Failure, _i10.NumberTrivia>(
              this,
              Invocation.method(
                #getRandomNumberTrivia,
                [],
              ),
            )),
            returnValueForMissingStub:
                _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>.value(
                    _FakeEither_3<_i9.Failure, _i10.NumberTrivia>(
              this,
              Invocation.method(
                #getRandomNumberTrivia,
                [],
              ),
            )),
          ) as _i8.Future<_i5.Either<_i9.Failure, _i10.NumberTrivia>>);
}

/// A class which mocks [NumberTriviaRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNumberTriviaRemoteDataSource extends _i1.Mock
    implements _i2.NumberTriviaRemoteDataSource {
  @override
  _i8.Future<_i6.NumberTriviaModel> getConcreteNumberTrivia(int? number) =>
      (super.noSuchMethod(
        Invocation.method(
          #getConcreteNumberTrivia,
          [number],
        ),
        returnValue:
            _i8.Future<_i6.NumberTriviaModel>.value(_FakeNumberTriviaModel_4(
          this,
          Invocation.method(
            #getConcreteNumberTrivia,
            [number],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i6.NumberTriviaModel>.value(_FakeNumberTriviaModel_4(
          this,
          Invocation.method(
            #getConcreteNumberTrivia,
            [number],
          ),
        )),
      ) as _i8.Future<_i6.NumberTriviaModel>);

  @override
  _i8.Future<_i6.NumberTriviaModel> getRandomNumberTrivia() =>
      (super.noSuchMethod(
        Invocation.method(
          #getRandomNumberTrivia,
          [],
        ),
        returnValue:
            _i8.Future<_i6.NumberTriviaModel>.value(_FakeNumberTriviaModel_4(
          this,
          Invocation.method(
            #getRandomNumberTrivia,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i6.NumberTriviaModel>.value(_FakeNumberTriviaModel_4(
          this,
          Invocation.method(
            #getRandomNumberTrivia,
            [],
          ),
        )),
      ) as _i8.Future<_i6.NumberTriviaModel>);
}

/// A class which mocks [NumberTriviaLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockNumberTriviaLocalDataSource extends _i1.Mock
    implements _i3.NumberTriviaLocalDataSource {
  @override
  _i8.Future<_i6.NumberTriviaModel> getLastNumberTrivia() =>
      (super.noSuchMethod(
        Invocation.method(
          #getLastNumberTrivia,
          [],
        ),
        returnValue:
            _i8.Future<_i6.NumberTriviaModel>.value(_FakeNumberTriviaModel_4(
          this,
          Invocation.method(
            #getLastNumberTrivia,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i8.Future<_i6.NumberTriviaModel>.value(_FakeNumberTriviaModel_4(
          this,
          Invocation.method(
            #getLastNumberTrivia,
            [],
          ),
        )),
      ) as _i8.Future<_i6.NumberTriviaModel>);

  @override
  _i8.Future<bool> cacheNumberTrivia(_i6.NumberTriviaModel? triviaToCache) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNumberTrivia,
          [triviaToCache],
        ),
        returnValue: _i8.Future<bool>.value(false),
        returnValueForMissingStub: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i4.NetworkInfo {
  @override
  _i8.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i8.Future<bool>.value(false),
        returnValueForMissingStub: _i8.Future<bool>.value(false),
      ) as _i8.Future<bool>);
}
