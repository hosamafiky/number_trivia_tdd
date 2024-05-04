import 'package:mockito/annotations.dart';
import 'package:number_trivia_tdd/core/network/network_info.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_local_datasource.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:number_trivia_tdd/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRepositoryImpl>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NumberTriviaRemoteDataSource>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NumberTriviaLocalDataSource>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<NetworkInfo>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {}
