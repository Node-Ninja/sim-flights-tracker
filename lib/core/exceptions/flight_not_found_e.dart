class FlightNotFoundException implements Exception {
  final String message;

  FlightNotFoundException(this.message);
}