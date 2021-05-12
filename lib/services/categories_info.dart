class Singleton {
  static final Singleton _singleton = Singleton._internal();
  Map<String, String> _categoriesInfo;

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}
