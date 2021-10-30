import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/TestCase.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/RevenueDAO.dart';

import '../App/Services.dart';
import '../DB/Database.dart';

class StartupController extends GetxController with StateMixin<void> {
  Rx<String> statusText = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    try {
      final startUpService = StartUpService();

      // Init global config
      statusText.value = 'Đang khởi tạo config...';
      await Get.putAsync(() => ConfigService().init(), permanent: true);

      // Init Database Services
      statusText.value = 'Đang khởi tạo database...';
      await Get.putAsync(() => DbService().init(), permanent: true);

      // Init Hiv services
      statusText.value = 'Đang register Adapter Hiv Service...';
      await startUpService.registerAdapterHivService();

      // Init Table Local
      statusText.value = 'Đang khởi tạo Table Local...';
      await Get.putAsync(() => TableLocalService().init(), permanent: true);

      // On Startup Run
      statusText.value = 'Đang setup onStartup...';
      await startUpService.onStartup();

      // Done
      statusText.value = 'Khởi tạo thành công';
      change(null, status: RxStatus.success());

      // Redirect
      Get.offNamed(AppConfig.initRoute);

      // Test case
      if (AppConfig.runTestCase) {
        final testCase = TestCase();
        await testCase.run();
      }
    } catch (error) {
      change(null, status: RxStatus.error());
      Utils.showSnackBar(
        'Lỗi',
        error.toString(),
      );
      // statusText.value =
      //     'Có lỗi khi khởi tạo, liên hệ anh đức đẹp trai, lỗi: \n${error.toString()} \nStack Trace: ${stack.toString()}';
    }
  }

  void queryTestData() async {}

  Future deleteFist() async {
    var db = Get.find<AppDatabase>();
    await db.delete(db.billCoupons).go();
    await db.delete(db.billItemProperties).go();
    await db.delete(db.billItems).go();
    await db.delete(db.bills).go();
  }
}
