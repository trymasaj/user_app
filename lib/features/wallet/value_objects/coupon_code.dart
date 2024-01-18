import 'package:flutter/material.dart';
import 'package:masaj/core/domain/value_objects/value_object.dart';

class CouponCode extends ValueObject<String> {
  CouponCode(super.value);

  @override
  bool isValid(String input) {
    return input.length == 8;
  }
}
