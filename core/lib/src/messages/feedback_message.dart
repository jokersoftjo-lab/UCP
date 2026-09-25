/// Feedback emitted by a receiver/target toward a controller.
enum UcpFeedbackType {
  vibration('vibration'),
  audio('audio'),
  notification('notification'),
  status('status'),
  game('game');

  const UcpFeedbackType(this.wireName);
  final String wireName;
}

class UcpFeedbackMessage {
  final UcpFeedbackType feedbackType;
  final Map<String, Object?> values;

  const UcpFeedbackMessage({
    required this.feedbackType,
    this.values = const {},
  });

  Map<String, Object?> toJson() => {
        'feedbackType': feedbackType.wireName,
        if (values.isNotEmpty) 'values': values,
      };
}
