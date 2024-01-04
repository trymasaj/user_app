
/// This class is used in the [conditionslist_item_widget] screen.
class ConditionslistItemModel {
  ConditionslistItemModel({
    this.allergiesText,
    this.id,
  }) {
    allergiesText = allergiesText ?? "Allergies";
    id = id ?? "";
  }

  String? allergiesText;

  String? id;
}
