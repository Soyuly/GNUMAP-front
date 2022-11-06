class ReviseModel {
  late String title = "";
  late String body = "";

  ReviseModel({title, body});

  Map<String, String> toJson() {
    final Map<String, String> json = <String, String>{};
    json['title'] = title;
    json['body'] = body;

    return json;
  }
}
