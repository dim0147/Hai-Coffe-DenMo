import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../DB/Database.dart';
import '../DAO/UserDAO.dart';
import '../Model/Cart.dart';

class DbService extends GetxService {
  Future<AppDatabase> init() async {
    // Generate DB
    AppDatabase db = AppDatabase();

    // Checkng have Admin
    UserDAO userDAO = new UserDAO(db);
    User? adminIsKnowledge = await userDAO.findUserByUsername('admin');

    // If don't have admin create new one
    if (adminIsKnowledge == null) {
      await userDAO.createAdminAccount();
    }
    return db;
  }
}

class HivService extends GetxService {
  Future<Box> init() async {
    // Connect hiv and register adapter
    await Hive.initFlutter();
    Hive.registerAdapter(CartAdapter());
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(CartItemAdapter());
    Hive.registerAdapter(CartItemPropertyAdapter());

    // Wait for open box
    Box box = await Hive.openBox(AppConfig.BOX_NAME);

    // Get cafe's tables
    var tables = box.get(AppConfig.BOX_TABLE_KEY_NAME);

    // If null then put empty list into box
    if (tables == null) {
      await box.put(AppConfig.BOX_TABLE_KEY_NAME, List.empty());
    }

    return box;
  }
}

class ConfigService extends GetxService {
  Future<ConfigGlobal> init() async {
    // Connect hiv and register adapter
    String? imgPath = await Utils.getImgDirectory();

    ConfigGlobal config = ConfigGlobal(imgPath: imgPath);

    return config;
  }
}
