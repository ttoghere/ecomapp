import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numOfNotifications")
  int? numOfNotifications;
  CustomResponse({
    this.id,
    this.name,
    this.numOfNotifications,
  });
  //FromJson
  factory CustomResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomResponseFromJson(json);
  //ToJson
  Map<String, dynamic> toJson() => _$CustomResponseToJson(this);
}

@JsonSerializable()
class ContactResponse {
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "phone")
  String? phone;
  ContactResponse({
    this.email,
    this.link,
    this.phone,
  });
  //FromJson
  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactResponseFromJson(json);
  //ToJson
  Map<String, dynamic> toJson() => _$ContactResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "customer")
  CustomResponse? customer;
  @JsonKey(name: "contacts")
  ContactResponse? contact;
  AuthenticationResponse({
    this.customer,
    this.contact,
  });
  //FromJson
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  //ToJson
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
