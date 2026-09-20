import 'content.dart';

class stepp {
  String? type;
  List<Content>? content;

  stepp({this.type, this.content});

  factory stepp.fromJson(Map<String, dynamic> json) => stepp(
    type: json['type'] as String?,
    content: (json['content'] as List<dynamic>?)
        ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'content': content?.map((e) => e.toJson()).toList(),
  };
}
