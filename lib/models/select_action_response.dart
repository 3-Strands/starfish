class ActionDetails {
  final String title, type, usedby, lastused;

  ActionDetails(
      {required this.title,
      required this.type,
      required this.usedby,
      required this.lastused});

  factory ActionDetails.fromJson(Map<String, dynamic> json) {
    return new ActionDetails(
      title: json['title'],
      type: json['type'],
      usedby: json['usedby'],
      lastused: json['lastused'],
    );
  }
}
