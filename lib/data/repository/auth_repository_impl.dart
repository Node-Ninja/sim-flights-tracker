import 'package:sim_flights_tracker/data/datasource/remote/sft/sft_datasource.dart';
import 'package:sim_flights_tracker/data/entity/_authed_user_details.dart';
import 'package:sim_flights_tracker/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{
  final SftDatasource _datasource;

  AuthRepositoryImpl(
      SftDatasource remoteDataSource): _datasource = remoteDataSource;

   @override
  Future<String?> startVatsimAuth() async {
    return await _datasource.startVatsimAuth();
  }

  @override
  Future<AuthedUserDetails?> getAuthedUserDetails(String authId) async {
    return await _datasource.getAuthedUserDetails(authId);
  }

  @override
  Future<String> vatsimLogout(String authId) async {
    return await _datasource.vatsimLogout(authId);
  }
}