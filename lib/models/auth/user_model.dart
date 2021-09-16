class User {
  int id;
  String username;
  String token;
  bool theme;


  User(
      {this.id = 0,
      this.username = "",
      this.token = "",
      this.theme = false,});

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
    id: data['id'],
    username: data['username'],
    token: data['token'],
    theme: (data['theme'] == 1)?  true: false,
  );

  Map<String, dynamic> toDatabaseJson() => {
    "id": this.id,
    "username": this.username,
    "token": this.token,
    "theme": this.theme,
  };

}
