// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

CustomResponse _$CustomResponseFromJson(Map<String, dynamic> json) =>
    CustomResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      numOfNotifications: json['numOfNotifications'] as int?,
    );

Map<String, dynamic> _$CustomResponseToJson(CustomResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'numOfNotifications': instance.numOfNotifications,
    };

ContactResponse _$ContactResponseFromJson(Map<String, dynamic> json) =>
    ContactResponse(
      email: json['email'] as String?,
      link: json['link'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ContactResponseToJson(ContactResponse instance) =>
    <String, dynamic>{
      'email': instance.email,
      'link': instance.link,
      'phone': instance.phone,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      customResponse: json['customer'] == null
          ? null
          : CustomResponse.fromJson(json['customer'] as Map<String, dynamic>),
      contactResponse: json['contacts'] == null
          ? null
          : ContactResponse.fromJson(json['contacts'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'customer': instance.customResponse,
      'contacts': instance.contactResponse,
    };
