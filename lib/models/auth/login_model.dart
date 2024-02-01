class LoginModel {
  final bool success;
  final String message;
  final String token;

  LoginModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      token: json['token'] ?? '',
    );
  }

}
