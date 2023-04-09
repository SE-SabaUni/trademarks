import 'package:content_app/logic/controller/HomeC.dart';
import 'package:content_app/logic/controller/addProductC.dart';
import 'package:content_app/logic/controller/addTrademarkC.dart';
import 'package:content_app/logic/controller/authC/forgetPasswordC.dart';
import 'package:content_app/logic/controller/searchC.dart';
import 'package:content_app/logic/controller/updateTrademarkC.dart';
import 'package:content_app/logic/controller/authC/verifyCode.dart';
import 'package:get/get.dart';
import '../controller/authC/authC.dart';

class myBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    //Get.put(LoginC());
    Get.lazyPut(() => AuthController(), fenix: true);
    // Get.lazyPut(() => forgetPassC(), fenix: true);
    Get.put(HomeController());
    Get.put(searchController());
    Get.lazyPut(() => AddProdcutC());
    //Get.put(AddTrademarkC());
    Get.lazyPut(() => updatetrademarkC());
    // Get.put(VerifyCodeController());
  }
}
