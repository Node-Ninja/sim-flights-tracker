import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/data/entity/_authed_user_details.dart';
import 'package:sim_flights_tracker/domain/repository/auth_repository.dart';

class GetAuthedUserDetailsUseCase implements UseCase<AuthedUserDetails?, String> {
  final AuthRepository _repository;

  GetAuthedUserDetailsUseCase(this._repository);

  @override
  Future<AuthedUserDetails?> call(String authId) async {
    return await _repository.getAuthedUserDetails(authId);
  }
}