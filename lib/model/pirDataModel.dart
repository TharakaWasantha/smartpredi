// ignore: file_names

class PirDataModel {
  dynamic epochTime;
  dynamic formatedtime;
  dynamic hour;
  dynamic minutes;
  dynamic month;
  dynamic monthDay;
  dynamic monthName;
  dynamic seconds;
  dynamic year;
  dynamic currentDate;

  PirDataModel(
      {required this.epochTime,
      required this.formatedtime,
      required this.hour,
      required this.minutes,
      required this.month,
      required this.monthDay,
      required this.monthName,
      required this.seconds,
      required this.year,
      required this.currentDate});

  factory PirDataModel.fromMap(Map<dynamic, dynamic> json) {
    return PirDataModel(
        epochTime: json["Epoch Time"],
        formatedtime: json["Formated Time"],
        hour: json["Hour"],
        minutes: json["Minutes"],
        month: json["Month"],
        monthDay: json["Month day"],
        monthName: json["Month name"],
        seconds: json["Seconds"],
        year: json["Year"],
        currentDate: json["current date"]);
  }
}
