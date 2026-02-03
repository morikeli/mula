class PinModel {
  final String pin;
  final String userId;

  const PinModel({
    required this.pin,
    required this.userId,
  });

  PinModel copyWith({
    String? pin,
    String? userId,
  }) {
    return PinModel(
      pin: pin ?? this.pin,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pin': pin,
      'userId': userId,
    };
  }

  factory PinModel.fromJson(Map<String, dynamic> json) {
    return PinModel(
      pin: json['pin'],
      userId: json['userId'],
    );
  }

  @override
  String toString() => '''PinModel(pin: $pin, userId: $userId)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PinModel &&
      other.pin == pin &&
      other.userId == userId;
  }

  @override
  int get hashCode => pin.hashCode ^ userId.hashCode;
}
