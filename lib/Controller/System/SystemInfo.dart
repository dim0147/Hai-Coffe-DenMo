import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SystemInfoController extends GetxController {
  Rxn<PackageInfo> packageInfo = Rxn<PackageInfo>();

  @override
  void onInit() async {
    packageInfo.value = await PackageInfo.fromPlatform();
  }
}
