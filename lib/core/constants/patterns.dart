class ValidationPatterns {
  static final RegExp alphaNumeric = RegExp(r'[0-9a-zA-Z]');

  //  Metar Wind RegEex
  static final RegExp windTypeOne = RegExp(r'(\d{5}KT)');
  static final RegExp windTypeTwo = RegExp(r'VRB\d{2}KT');
  static final RegExp windTypeThree = RegExp(r'(\d{5}MPS)');
  static final RegExp windTypeFour = RegExp(r'(\d{5}G\d{2}KT)');

  //  Metar Temperature
  static final RegExp dewTemperature = RegExp(r'(\d{2}/\d{2})');

  //  Metar altimeter;
  static final RegExp euroAltimeter = RegExp(r'(Q\d{4})');
  static final RegExp americaAltimeter = RegExp(r'(A\d{4})');
}