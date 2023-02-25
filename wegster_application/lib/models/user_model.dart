// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  int? id;
  String? token;
  String? username;
  String? email, name, address;
  int? is_user;
  User({this.id, this.name, this.email, this.address, this.is_user
      //this.phone,
      });

  factory User.fromJson(json) {
    print(json);
    return User(
        id: json["pk"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        is_user: json["user_type"]);
    //phone: json["phone"]);
  }
}
