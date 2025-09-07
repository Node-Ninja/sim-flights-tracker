import 'package:sim_flights_tracker/data/entity/_authed_user_details.dart';

abstract class AuthRepository {
  Future<String?> startVatsimAuth();

  Future<AuthedUserDetails?> getAuthedUserDetails(String authId);

  Future<String> vatsimLogout(String authId);
}