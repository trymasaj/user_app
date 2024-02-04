class Country {
  final int? id;
  final String? nameEn;
  final String? nameAr;
  final String? code;
  final String? currencyEn;
  final String? currencyAr;
  final int? decimalNumber;
  final String? currencyIso;
  final String? isoCode;
  final String? capital;
  final int usdExchangeRate;
  final bool? isActive;
  final String? flagIcon;

  Country({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.code,
    required this.currencyEn,
    required this.currencyAr,
    required this.decimalNumber,
    required this.currencyIso,
    required this.isoCode,
    required this.capital,
    required this.usdExchangeRate,
    required this.isActive,
    required this.flagIcon,
  });

  factory Country.fromMap(Map<String?, dynamic> map) {
    return Country(
      id: map['id'],
      nameEn: map['nameEn'],
      nameAr: map['nameAr'],
      code: map['code'],
      currencyEn: map['currencyEn'],
      currencyAr: map['currencyAr'],
      decimalNumber: map['decimalNumber'],
      currencyIso: map['currencyIso'],
      isoCode: map['isoCode'],
      capital: map['capital'],
      usdExchangeRate: map['usdExchangeRate'],
      isActive: map['isActive'],
      flagIcon: map['flagIcon'],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'nameEn':nameEn,
      'nameAr':nameAr,
      'code':code,
      'currencyEn':currencyEn,
      'currencyAr':currencyAr,
      'decimalNumber':decimalNumber,
      'currencyIso':currencyIso,
      'isoCode':isoCode,
      'capital':capital,
      'usdExchangeRate':usdExchangeRate,
      'isActive':isActive,
      'flagIcon':flagIcon,
    };
  }
}
