import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hai_noob/App/Config.dart';
import 'package:hai_noob/App/Utils.dart';
import 'package:hai_noob/Controller/Bill/BillDetailController.dart';
import 'package:hai_noob/DAO/BillDAO.dart';
import 'package:hai_noob/DB/Database.dart';
import 'package:hai_noob/Model/Bill.dart';

class BillDetailScreen extends GetView<BillDetailController> {
  const BillDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BillEntity billEntity = controller.args.billEntity;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chi tiết Bill'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(billEntity: billEntity),
              ListItem(billEntity: billEntity),
              SubTotalWidget(billEntity: billEntity),
              if (billEntity.coupons.length > 0)
                ListCoupon(coupons: billEntity.coupons),
              TotalWidget(billEntity: billEntity),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.billEntity,
  }) : super(key: key);

  final BillEntity billEntity;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Bill ID: #${billEntity.bill.id}',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Text(
            'Thoanh toán lúc: ${Utils.dateExtension.dateToDateWithTime(billEntity.bill.createdAt)}',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          Divider(
            thickness: 2.0,
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
    required this.billEntity,
  }) : super(key: key);

  final BillEntity billEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: billEntity.items
          .map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    BillItemWidget(billItemEntity: e),
                    Divider(
                      thickness: 1.0,
                      indent: 5.0,
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class BillItemWidget extends StatelessWidget {
  final BillItemEntity billItemEntity;

  const BillItemWidget({
    Key? key,
    required this.billItemEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BillItem item = billItemEntity.item;
    final List<BillItemPropertie> properties = billItemEntity.properties;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BillItemHeader(item: item),
        // Properties list
        if (properties.length > 0)
          Column(
            children: properties
                .map((e) => BillItemProperties(
                      property: e,
                      itemQuantity: item.totalQuantity,
                    ))
                .toList(),
          )
      ],
    );
  }
}

class BillItemProperties extends StatelessWidget {
  final int itemQuantity;
  final BillItemPropertie property;
  const BillItemProperties({
    Key? key,
    required this.property,
    required this.itemQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
              '+ ${property.name} (${Utils.formatDouble(property.propertyPrice)}đ x ${property.totalQuantity})'),
          Spacer(),
          Text('x$itemQuantity'),
          SizedBox(
            width: 10.0,
          ),
          Text('${Utils.formatDouble(property.totalPriceMinusItemQuantity)}đ')
        ],
      ),
    );
  }
}

class BillItemHeader extends StatelessWidget {
  const BillItemHeader({
    Key? key,
    required this.item,
  }) : super(key: key);

  final BillItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FadeInImage(
          placeholder: AssetImage(AppConfig.DEFAULT_IMG_ITEM),
          image: Utils.getImgProvider(item.itemImg),
          height: 50,
          width: 70,
        ),
        Text('${item.itemName} (${Utils.formatDouble(item.itemPrice)}đ)'),
        Spacer(),
        Text('x${item.totalQuantity}'),
        SizedBox(
          width: 20.0,
        ),
        Text('${Utils.formatDouble(item.totalPrice)}đ')
      ],
    );
  }
}

class SubTotalWidget extends StatelessWidget {
  const SubTotalWidget({
    Key? key,
    required this.billEntity,
  }) : super(key: key);

  final BillEntity billEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            'Sub Total: ${Utils.formatDouble(billEntity.bill.subTotal)}đ',
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        )
      ],
    );
  }
}

class ListCoupon extends StatelessWidget {
  final List<BillCoupon> coupons;
  const ListCoupon({
    Key? key,
    required this.coupons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          thickness: 2.0,
        ),
        Text(
          'Coupon',
          style: TextStyle(fontSize: 20.0),
        ),
        ...coupons
            .map((e) => CouponWidget(
                  billCoupon: e,
                ))
            .toList()
      ],
    );
  }
}

class CouponWidget extends StatelessWidget {
  final BillCoupon billCoupon;

  const CouponWidget({
    Key? key,
    required this.billCoupon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String plusOrMinusString =
        billCoupon.couponType == CouponType.increase ? '+' : '-';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            '+ ${billCoupon.name}',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          Spacer(),
          Text(
              '$plusOrMinusString ${Utils.formatDouble(billCoupon.price)}đ (${billCoupon.percent}%)'),
        ],
      ),
    );
  }
}

class TotalWidget extends StatelessWidget {
  const TotalWidget({
    Key? key,
    required this.billEntity,
  }) : super(key: key);

  final BillEntity billEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 2.0),
        Row(
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'TỔNG CỘNG: ${Utils.formatDouble(billEntity.bill.totalPrice)}đ',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
