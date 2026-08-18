class Content {
  String? type;
  String? text;

  Content({this.type, this.text});

  factory Content.fromJson(Map<String, dynamic> json) =>
      Content(type: json['type'] as String?, text: json['text'] as String?);

  Map<String, dynamic> toJson() => {'type': type ?? "text", 'text': text};
}
