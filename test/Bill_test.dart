import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart';

void main() {
  test('Get list bill', () async {
    final AppDatabase appDb = AppDatabase();

    final BillDAO billDAO = BillDAO(appDb);

    var ad;
  });
}
