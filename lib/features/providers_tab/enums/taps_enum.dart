import 'package:masaj/core/app_text.dart';

enum TherapistTabsEnum { all, favorites, past }
 
extension TherapistsTabsEnumExt on TherapistTabsEnum{
  String get name {
    switch (this){
      case TherapistTabsEnum.all : return AppText.all;
      case TherapistTabsEnum.favorites : return AppText.favorites;
      case TherapistTabsEnum.past : return AppText.past;
    }
  }
}