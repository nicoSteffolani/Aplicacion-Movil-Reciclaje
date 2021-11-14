import 'dart:core';

class UserLogin {
  String? username;
  String? password;

  UserLogin({this.username, this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "password": this.password
  };
}
class UserRegister {
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? password2;

  UserRegister({
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.password2,
  });

  Map <String, dynamic> toDatabaseJson() => {
    "username": this.username,
    "email": this.email,
    "first_name":this.firstName,
    "last_name": this.lastName,
    "password": this.password,
    "password2": this.password2,

  };
}

class Token{
  String token;

  Token({this.token = ""});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['token']
    );
  }
}

