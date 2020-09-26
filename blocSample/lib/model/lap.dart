class Lap {
  final int minute;
  final int second;
  final int centisecond;
  final int order;

  Lap({this.order, this.minute, this.second, this.centisecond});

  Map<String, dynamic> toMap() {
    return {
      'order': order,
      'minute': minute,
      'second': second,
      'centisecond': centisecond
    };
  }

  // Implement toString to make it easier to see information about
  // each lap when using the print statement.
  @override
  String toString() {
    return 'Lap{order: $order, minute: $minute, second: $second, centisecond: $centisecond}';
  }
}
