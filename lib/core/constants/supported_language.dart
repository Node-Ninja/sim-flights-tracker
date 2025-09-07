enum SupportedLanguage {
  af('ZA', 'Afrikaans'),
  en('GB', 'English'),
  id('ID', 'Indonesian'),
  ru('RU', 'Russian'),
  tn('ZA', 'Setswana');


  final String language;
  final String countryCode;
  const SupportedLanguage(this.countryCode, this.language);
}