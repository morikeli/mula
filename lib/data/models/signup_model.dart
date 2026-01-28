class SignupModel {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String pwd;
  final String confirmPwd;

  const SignupModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.pwd,
    required this.confirmPwd,
  });

  SignupModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? pwd,
    String? confirmPwd,
  }) {
    return SignupModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      pwd: pwd ?? this.pwd,
      confirmPwd: confirmPwd ?? this.confirmPwd,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'pwd': pwd,
      'confirmPwd': confirmPwd,
    };
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      pwd: json['pwd'],
      confirmPwd: json['confirmPwd'],
    );
  }

  @override
  String toString() {
    return '''SignupModel(firstName: $firstName, lastName: $lastName, email: $email, mobileNumber: $mobileNumber, pwd: $pwd, confirmPwd: $confirmPwd)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SignupModel &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.email == email &&
      other.mobileNumber == mobileNumber &&
      other.pwd == pwd &&
      other.confirmPwd == confirmPwd;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      email.hashCode ^
      mobileNumber.hashCode ^
      pwd.hashCode ^
      confirmPwd.hashCode;
  }
}
