extension LastChars on String {
  String takeLast(int n) {
    if (n > length) return this;
    return substring(length - n);
  }
}

extension FirstChars on String {
  String takeFirst(int n) {
    if (n > length) return this;
    return substring(0, n);
  }
}