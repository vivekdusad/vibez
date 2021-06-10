// @dart=2.12
class CustomException {
  String message;
  CustomException({
    required this.message,
  });

  CustomException copyWith({
    String? message,
  }) {
    return CustomException(
      message: message ?? this.message,
    );
  } 

  @override
  String toString() => 'CustomException(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CustomException &&
      other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
