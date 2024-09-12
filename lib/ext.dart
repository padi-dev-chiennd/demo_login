import 'package:device_info_plus/device_info_plus.dart';
Future<int> getAndroidVersion() async {
  final deviceInfo = DeviceInfoPlugin();
  final androidInfo = await deviceInfo.androidInfo;
  return androidInfo.version.sdkInt; // Returns the SDK version as an integer
}