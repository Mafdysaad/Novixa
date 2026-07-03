class ChatMessageModel {
  ChatMessageModel({required this.type, this.text, this.uri, this.mimeType});

  final String type;
  final String? text;
  final String? uri;
  final String? mimeType;

  factory ChatMessageModel.text(String text) {
    return ChatMessageModel(type: 'text', text: text);
  }

  factory ChatMessageModel.image({
    required String uri,
    required String mimeType,
  }) {
    return ChatMessageModel(type: 'image', uri: uri, mimeType: mimeType);
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      type: json['type'] as String,
      text: json['text'] as String?,
      uri: json['uri'] as String?,
      mimeType: json['mime_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{'type': type};
    if (text != null) map['text'] = text;
    if (uri != null) map['uri'] = uri;
    if (mimeType != null) map['mime_type'] = mimeType;
    return map;
  }
}
