import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';

Future<bool> duck({required String iosAppId}) async {
  final x = await duckerInfo(iosAppId: iosAppId);
  return x.duck;
}

Future<DuckerInfo> duckerInfo({required String iosAppId}) async {
  // package version
  final i = await PackageInfo.fromPlatform();
  final packageVersion = Version.parse(i.version);

  // live iOS version
  final uri = Uri.parse('https://itunes.apple.com/lookup?id=$iosAppId');
  final res = await http.get(uri);
  final json = jsonDecode(res.body);
  final liveIosVersion = Version.parse(json['results'][0]['version']);

  // results
  return DuckerInfo(
    deployedIosVersion: liveIosVersion,
    packageVersion: packageVersion,
  );
}

class DuckerInfo {
  final Version deployedIosVersion;

  final Version packageVersion;

  DuckerInfo({required this.deployedIosVersion, required this.packageVersion});

  bool get appIsLive => deployedIosVersion >= packageVersion;

  bool get duck => !appIsLive;
}
