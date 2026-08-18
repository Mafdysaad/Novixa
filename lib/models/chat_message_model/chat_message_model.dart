import 'dart:convert';

import 'package:ai_chat_bot/models/chat_message_model/content.dart';

import 'step.dart';
import 'usage.dart';

class ChatMessageModel {
  String? id;
  String? status;
  Usage? usage;
  List<Step>? steps;
  String? object;
  String? model;

  ChatMessageModel({
    this.id,
    this.status,
    this.usage,
    this.steps,
    this.object,
    this.model,
  });
  var content = ChatMessageModel().steps!.first.content;
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String?,
      status: json['status'] as String?,
      usage: json['usage'] == null
          ? null
          : Usage.fromJson(json['usage'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => Step.fromJson(e as Map<String, dynamic>))
          .toList(),
      object: json['object'] as String?,
      model: json['model'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'status': status,
    'usage': usage?.toJson(),
    'steps': steps?.map((e) => e.toJson()).toList(),
    'object': object,
    'model': model,
  };
}
