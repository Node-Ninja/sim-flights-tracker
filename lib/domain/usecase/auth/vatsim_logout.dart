import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/domain/repository/auth_repository.dart';

class VatsimLogoutUseCase implements UseCase<String, String> {
  final AuthRepository _repository;

  VatsimLogoutUseCase(this._repository);

  @override
  Future<String> call(String authId) async {
    return await _repository.vatsimLogout(authId);
  }
}