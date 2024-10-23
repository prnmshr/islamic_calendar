import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

GetDate getDateFromJson(String str) => GetDate.fromJson(json.decode(str));

String getDateToJson(GetDate data) => json.encode(data.toJson());

class GetDate {
    int code;
    String status;
    Data data;

    GetDate({
        required this.code,
        required this.status,
        required this.data,
    });

    factory GetDate.fromJson(Map<String, dynamic> json) => GetDate(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    Hijri hijri;
    Gregorian gregorian;

    Data({
        required this.hijri,
        required this.gregorian,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        hijri: Hijri.fromJson(json["hijri"]),
        gregorian: Gregorian.fromJson(json["gregorian"]),
    );

    Map<String, dynamic> toJson() => {
        "hijri": hijri.toJson(),
        "gregorian": gregorian.toJson(),
    };
}

class Gregorian {
    String date;
    String format;
    String day;
    GregorianWeekday weekday;
    GregorianMonth month;
    String year;
    Designation designation;

    Gregorian({
        required this.date,
        required this.format,
        required this.day,
        required this.weekday,
        required this.month,
        required this.year,
        required this.designation,
    });

    factory Gregorian.fromJson(Map<String, dynamic> json) => Gregorian(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: GregorianWeekday.fromJson(json["weekday"]),
        month: GregorianMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
    };
}

class Designation {
    String abbreviated;
    String expanded;

    Designation({
        required this.abbreviated,
        required this.expanded,
    });

    factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        abbreviated: json["abbreviated"],
        expanded: json["expanded"],
    );

    Map<String, dynamic> toJson() => {
        "abbreviated": abbreviated,
        "expanded": expanded,
    };
}

class GregorianMonth {
    int number;
    String en;

    GregorianMonth({
        required this.number,
        required this.en,
    });

    factory GregorianMonth.fromJson(Map<String, dynamic> json) => GregorianMonth(
        number: json["number"],
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
    };
}

class GregorianWeekday {
    String en;

    GregorianWeekday({
        required this.en,
    });

    factory GregorianWeekday.fromJson(Map<String, dynamic> json) => GregorianWeekday(
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
    };
}

class Hijri {
    String date;
    String format;
    String day;
    HijriWeekday weekday;
    HijriMonth month;
    String year;
    Designation designation;
    List<dynamic> holidays;

    Hijri({
        required this.date,
        required this.format,
        required this.day,
        required this.weekday,
        required this.month,
        required this.year,
        required this.designation,
        required this.holidays,
    });

    factory Hijri.fromJson(Map<String, dynamic> json) => Hijri(
        date: json["date"],
        format: json["format"],
        day: json["day"],
        weekday: HijriWeekday.fromJson(json["weekday"]),
        month: HijriMonth.fromJson(json["month"]),
        year: json["year"],
        designation: Designation.fromJson(json["designation"]),
        holidays: List<dynamic>.from(json["holidays"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "format": format,
        "day": day,
        "weekday": weekday.toJson(),
        "month": month.toJson(),
        "year": year,
        "designation": designation.toJson(),
        "holidays": List<dynamic>.from(holidays.map((x) => x)),
    };
}

class HijriMonth {
    int number;
    String en;
    String ar;

    HijriMonth({
        required this.number,
        required this.en,
        required this.ar,
    });

    factory HijriMonth.fromJson(Map<String, dynamic> json) => HijriMonth(
        number: json["number"],
        en: json["en"],
        ar: json["ar"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "en": en,
        "ar": ar,
    };
}

class HijriWeekday {
    String en;
    String ar;

    HijriWeekday({
        required this.en,
        required this.ar,
    });

    factory HijriWeekday.fromJson(Map<String, dynamic> json) => HijriWeekday(
        en: json["en"],
        ar: json["ar"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
        "ar": ar,
    };
}

Future<GetDate?> fetchDateFromGregorian(String date) async {
  final response = await http.get(Uri.parse('http://api.aladhan.com/v1/gToH/$date'));

  if (response.statusCode == 200) {
    return getDateFromJson(response.body);
  } else {
    // Jika gagal mendapatkan data
    if (kDebugMode) {
      print('Failed to load date');
    }
    return null;
  }
}

Future<GetDate?> fetchDateFromHijri(String date) async {
  final response = await http.get(Uri.parse('http://api.aladhan.com/v1/hToG/$date'));

  if (response.statusCode == 200) {
    return getDateFromJson(response.body);
  } else {
    if (kDebugMode) {
      print('Failed to load date');
    }
    return null;
  }
}