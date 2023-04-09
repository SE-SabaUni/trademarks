import 'package:content_app/logic/controller/addTrademarkC.dart';
import 'package:content_app/logic/controller/updateTrademarkC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/validation.dart';
import '../../widget/customComponent.dart';

class updateTrademark extends GetView<updatetrademarkC> {
  const updateTrademark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar(context, 'تحديث علامة تجارية'),
        body: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                dropdown("العلامة التجارية :", context,
                    controller.selectedTrademark, controller.trademarks),
                const SizedBox(
                  height: 10,
                ),
                row("رابط المستندات :", controller.cocumentsLink, (value) {
                  return validInput(value!, 15, 100, "link");
                }, context),
                const SizedBox(
                  height: 20,
                ),
                // GetBuilder<AddTrademarkC>(
                //   builder: (builder) => datefield(context, controller.dateinput,
                //       "تاريخ التحديث :", controller,controller.),
                // ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 250,
                  child: button(" حفظ", () {}, context),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
