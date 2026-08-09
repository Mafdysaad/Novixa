import 'content.dart';

class Step {
	String? type;
	List<Content>? content;

	Step({this.type, this.content});

	factory Step.fromJson(Map<String, dynamic> json) => Step(
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
