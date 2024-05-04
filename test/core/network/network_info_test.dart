import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_tdd/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<InternetConnectionChecker>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group(
    'isConnected',
    () {
      test(
        'should forward the call to InternetConnectionChecker.hasConnection',
        () async {
          // arrange
          when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => Future.value(true));
          // act
          final result = await networkInfoImpl.isConnected;
          // assert
          verify(mockInternetConnectionChecker.hasConnection);
          expect(result, isTrue);
        },
      );
    },
  );
}
