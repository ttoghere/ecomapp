import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:ecomapp/app/app_shelf.dart';
import 'package:flutter/services.dart';

Future<DeviceInfo> getDeviceDetails() async {
  String name = "Unknown";
  String identifier = "Unknown";
  String version = "Unknown";
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      name = "${build.brand} ${build.model}";
      identifier = build.androidId;
      version = build.version.codename;
    } else if (Platform.isIOS) {
      var build = await deviceInfoPlugin.iosInfo;
      name = "${build.name} ${build.model}";
      identifier = build.identifierForVendor;
      version = build.systemVersion;
    }
  } on PlatformException {
    //Varsayılan değer gelir
    return DeviceInfo(
      name: name,
      identifier: identifier,
      version: version,
    );
  }
  return DeviceInfo(
    name: name,
    identifier: identifier,
    version: version,
  );
}
