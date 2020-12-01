import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
 String name;
 String salary;
 String age;
 String id;

 UserModel({
  this.name,
  this.salary,
  this.age,
  this.id,
 });

 factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  name: json["name"],
  salary: json["salary"],
  age: json["age"],
  id: json["id"],
 );

 Map<String, dynamic> toJson() => {
  "name": name,
  "salary": salary,
  "age": age,
  "id": id,
 };
}