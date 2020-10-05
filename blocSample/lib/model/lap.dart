class Lap {
  final int minute;
  final int second;
  final int centisecond;
  final int id;

  Lap({this.id, this.minute, this.second, this.centisecond});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'minute': minute,
      'second': second,
      'centisecond': centisecond
    };
  }

  int getID() {
    return id;
  }

  int getMin() {
    return minute;
  }

  int getSec() {
    return second;
  }

  int getCentisec() {
    return centisecond;
  }

  // Implement toString to make it easier to see information about
  // each lap when using the print statement.
  @override
  String toString() {
    return 'Lap{id: $id, minute: $minute, second: $second, centisecond: $centisecond}';
  }
}
