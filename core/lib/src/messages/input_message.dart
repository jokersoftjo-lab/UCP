/// Supported UCP input event kinds.
enum UcpInputType {
  button('button'),
  axis('axis'),
  trigger('trigger'),
  dpad('dpad'),
  motion('motion'),
  keyboard('keyboard'),
  mouse('mouse'),
  touchpad('touchpad');

  const UcpInputType(this.wireName);
  final String wireName;
}

class UcpInputMessage {
  final UcpInputType inputType;
  final String control;
  final Map<String, Object?> values;

  const UcpInputMessage({
    required this.inputType,
    required this.control,
    this.values = const {},
  });

  Map<String, Object?> toJson() => {
        'inputType': inputType.wireName,
        'control': control,
        if (values.isNotEmpty) 'values': values,
      };
}
