class UserModel{
  int id;
  String name;
  String password;

  UserModel({ this.id,  this.name,  this.password});


  static const ID = "id";
  static const NAME = "name";
  static const PASSWORD = "password";

  static final List<String> values = [
    /// Add all fields
    ID,  NAME,PASSWORD,
  ];


  static UserModel fromJson(Map<String, Object> json) => UserModel(
    id: json[ID] as int,
    password: json[PASSWORD] as String,
    name: json[NAME] as String,

  );

  Map<String, Object> toJson() => {
    ID: id,
    NAME: name,
    PASSWORD: password,
  };

}