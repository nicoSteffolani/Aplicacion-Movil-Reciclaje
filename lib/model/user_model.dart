class User {
  String username;
  String token;

  User(
      {
      this.username = "",
      this.token = ""});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(

      username: data['username'],
      token: data['token'],
  );

  Map<String, dynamic> toDatabaseJson() => {

        "username": this.username,
        "token": this.token
      };
}
