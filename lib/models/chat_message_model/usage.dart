class Usage {
	int? totalTokens;

	Usage({this.totalTokens});

	factory Usage.fromJson(Map<String, dynamic> json) => Usage(
				totalTokens: json['total_tokens'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'total_tokens': totalTokens,
			};
}
