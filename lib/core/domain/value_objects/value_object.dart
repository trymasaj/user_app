import 'package:dartz/dartz.dart';

abstract class ValueObject<T> {
  const ValueObject(this.value);

  final T value;

  T getOrCrash() {

    return value;
  }


  bool isValid(T input) {
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}