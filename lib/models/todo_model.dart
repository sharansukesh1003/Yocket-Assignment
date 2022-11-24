class TodoModel {
  String id;
  String title;
  String minutes;
  String seconds;
  String colorIndex;
  String startMinute;
  String startSecond;

  TodoModel({
    required this.id,
    required this.title,
    required this.minutes,
    required this.seconds,
    required this.startMinute,
    required this.startSecond,
    required this.colorIndex,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'minutes': minutes,
      'seconds': seconds,
      'colorIndex': colorIndex,
      'startMinute': startMinute,
      'startSecond': startSecond
    };
  }

  TodoModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        minutes = json['minutes'],
        seconds = json['seconds'],
        colorIndex = json['colorIndex'],
        startMinute = json['startMinute'],
        startSecond = json['startSecond'];
}
