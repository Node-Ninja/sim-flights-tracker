extension EnumExtensions <T extends Enum> on List<T> {
  T byNameOrDefault (String name, T fallback) {
    try {
      return byName(name);
    } catch (_) {
      return fallback;
    }
  }
}