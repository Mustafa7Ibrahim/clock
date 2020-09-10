class AlarmModel {
  int id;
  String lable;
  DateTime dateTime;
  bool enable;
  List days;

  AlarmModel({
    this.id,
    this.lable,
    this.dateTime,
    this.enable,
    this.days,
  });

  factory AlarmModel.fromJson(Map<String, dynamic> json) => AlarmModel(
        id: json['id'],
        lable: json['lable'],
        dateTime: DateTime.parse(json['dateTime']),
        enable: json['enable'] == 1,
        // days: List<String>.from(json['days'].map((e) => e)),
      );

  Map<String, dynamic> tojson() => {
        'id': id,
        'lable': lable,
        'datetime': dateTime.toIso8601String(),
        'enable': enable == true ? 1 : 0,
        // 'days': List<dynamic>.from(days.map((e) => e)),
      };
}
