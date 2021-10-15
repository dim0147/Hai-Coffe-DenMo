import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/DAO/TableOrderDAO.dart';
import 'package:hai_noob/DAO/TableLocalDAO.dart';
import 'package:hai_noob/Model/ConfigGlobal.dart';
import 'package:hai_noob/Model/TableLocal.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../DB/Database.dart';
import '../DAO/UserDAO.dart';
import '../Model/Cart.dart';

class DbService extends GetxService {
  Future<AppDatabase> init() async {
    // Generate DB
    AppDatabase db = AppDatabase();

    // Checking have Admin
    UserDAO userDAO = new UserDAO(db);
    User? adminIsKnowledge = await userDAO.findUserByUsername('admin');

    // If don't have admin create new one
    if (adminIsKnowledge == null) {
      await userDAO.createAdminAccount();
    }
    return db;
  }
}

class TableLocalService extends GetxService {
  Future<TableLocalDAO> init() async {
    // Wait for open box
    final box = await Hive.openBox<TableLocal>(AppConfig.BOX_NAME);
    return TableLocalDAO(box: box);
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

class StartUpService {
  Future<void> registerAdapterHivService() async {
    // Connect hiv and register adapter
    await Hive.initFlutter();
    Hive.registerAdapter(CartAdapter());
    Hive.registerAdapter(ItemAdapter());
    Hive.registerAdapter(CartItemAdapter());
    Hive.registerAdapter(CartItemPropertyAdapter());
    Hive.registerAdapter(TableStatusAdapter());
    Hive.registerAdapter(TableLocalAdapter());
  }

  Future<void> onStartup() async {
    await checkingTableOrder();
  }

  Future<void> checkingTableOrder() async {
    // Get db
    final db = Get.find<AppDatabase>();

    // Get box
    final tableLocalDAO = Get.find<TableLocalDAO>();

    // Get all table locals
    final tableLocals = tableLocalDAO.getAllWithMap();

    // Get all tables DB
    final tableOrders = await TableOrderDAO(db).getAllTableOrders();

    // TODO: Test this shit
    // Remove table where id don't exist in database
    // Map<dynamic, TableLocal> tableLocalsExistIDs = Map.from(tableLocals)
    //   ..removeWhere((key, value) => tableOrders.every((e) => e.id != key));
    // await tableLocalDAO.updateAllByMap(tableLocalsExistIDs);

    // Loop all table orders to checking
    tableOrders.forEach((e) {
      // Check box have the table order's ID already
      if (tableLocalDAO.getTable(e.id) != null) return;

      // Box don't have this table id, we added new one
      final newTableLocal = TableLocal(
        id: e.id,
        name: e.name,
        cart: Cart(tableId: e.id, items: []),
        order: e.order,
      );
      tableLocalDAO.addNew(newTableLocal);
    });
  }
}
