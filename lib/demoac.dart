class Singleton {
  int id;

  static final Singleton _inst = Singleton._internal();

  Singleton._internal() {
    // some logic
  }

  factory Singleton({int id}) {
    _inst.id = id;
    return _inst;
  }
}