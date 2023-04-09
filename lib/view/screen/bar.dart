import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:content_app/view/widget/customComponent.dart';
import 'package:content_app/view/screen/auth/auth.dart';
import 'package:content_app/view/screen/home.dart';
import 'package:content_app/view/screen/notifications.dart';
import 'package:content_app/view/screen/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/controller/HomeC.dart';

class Bar extends GetView<HomeController> {
  const Bar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: controller.pageController,
            onPageChanged: (index) {
              //  controller.currentIndex.value = index;
              controller.onChange(index);
            },
            children: <Widget>[Home(), Search(), NotifiPage()],
          ),
        ),
        bottomNavigationBar: GetX<HomeController>(
            builder: (controller) => BottomNavyBar(
                  selectedIndex: controller.currentIndex.value,
                  onItemSelected: (index) {
                    controller.onChange(index);
                    controller.pageController.jumpToPage(index);
                  },
                  items: <BottomNavyBarItem>[
                    bottomBarItem('الرئيسية', Icons.home),
                    bottomBarItem('البحث', Icons.search),
                    bottomBarItem('الاشعارات', Icons.notification_add),
                  ],
                )),
      ),
    );
  }
}
