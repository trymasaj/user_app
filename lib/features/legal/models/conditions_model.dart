// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'conditionslist_item_model.dart';

/// This class defines the variables used in the [conditions_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class ConditionsModel extends Equatable {
  ConditionsModel({this.conditionslistItemList = const []}) {}

  List<ConditionslistItemModel> conditionslistItemList;

  ConditionsModel copyWith(
      {List<ConditionslistItemModel>? conditionslistItemList}) {
    return ConditionsModel(
      conditionslistItemList:
          conditionslistItemList ?? this.conditionslistItemList,
    );
  }

  @override
  List<Object?> get props => [conditionslistItemList];
}
