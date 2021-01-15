import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  User({
    this.token,
    this.errorcode,
    this.avatar,
    this.firstname,
    this.id,
    this.lastname,
    this.email,
  });

  final int id;

  @JsonKey(name: "errorcode")
  final int errorcode;

  @JsonKey(name: "first_name")
  final String firstname;

  @JsonKey(name: "last_name")
  final String lastname;

  @JsonKey(name: "e_mail")
  final String email;

  final String avatar;

  @JsonKey(nullable: true)
  String token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$firstname $lastname".toString();
  }
}
