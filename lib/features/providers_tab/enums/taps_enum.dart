import 'package:masaj/core/app_text.dart';

enum TherapistTabsEnum { all, past, favorites }
 
extension TherapistsTabsEnumExt on TherapistTabsEnum{
  String get name {
    switch (this){
      case TherapistTabsEnum.all : return AppText.all;
      case TherapistTabsEnum.past : return AppText.past;
      case TherapistTabsEnum.favorites : return AppText.favorites;
    }
  }
}