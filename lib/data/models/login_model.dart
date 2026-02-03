class LoginModel {
  final String email;
  final String password;

  const LoginModel({required this.email, required this.password});

  LoginModel copyWith({String? email, String? password}) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(email: json['email'], password: json['password']);
  }

  @override
  String toString() => '''LoginModel(email: $email, password: $password)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginModel &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
