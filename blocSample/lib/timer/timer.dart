class Ticker {
  Stream<int> tick({int counter}) {
    return Stream<int>.periodic(
        const Duration(seconds: 1), (x) => counter - x % (counter + 1));
  }
}
