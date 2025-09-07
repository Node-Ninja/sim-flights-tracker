import 'package:sim_flights_tracker/core/dependency_injection/use_case.dart';
import 'package:sim_flights_tracker/domain/repository/auth_repository.dart';

class GetStartAuthUseCase implements UseCase<String?, String> {
  final AuthRepository _repository;

  GetStartAuthUseCase(this._repository);

  @override
  Future<String?> call(String params) async {
    return await _repository.startVatsimAuth();
  }
}