import 'package:content_app/main.dart';
import 'package:content_app/view/screen/product/addProduct.dart';
import 'package:content_app/view/screen/trademark/addTrademarks.dart';
import 'package:content_app/view/screen/trademark/updateTrademark.dart';
import 'package:content_app/view/screen/trader.dart';
import 'package:content_app/view/widget/customComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../services/Crud.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      color: Color(0xff383232),
      width: MediaQuery.of(context).size.width - 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 600,
              color: Colors.white,
              child: Text(
                '${sharedPreference.getString('email')}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          listTile(context, 'إضافة علامة تجارية', Icons.add_moderator, () {
            Get.to(AddTrademark());
          }),
          listTile(context, 'تحديث علامة تجارية', Icons.refresh, () {
            Get.to(updateTrademark());
          }),
          listTile(context, 'إضافة منتج', Icons.add, () {
            Get.to(AddProduct());
          }),
          listTile(context, 'إضافة تاجر', Icons.add, () {
            Get.to(AddTrader());
          }),
          Divider(
            color: Colors.white,
          ),
          listTile(context, 'عن التطبيق', Icons.info, () {
            Get.to(AddProduct());
          }),
          listTile(context, ' تسجيل خروج', Icons.logout, () {
            Crud().logout();
          }),
        ],
      ),
    );
  }
}
