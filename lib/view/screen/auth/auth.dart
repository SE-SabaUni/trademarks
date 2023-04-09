import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/services/validation.dart';
import 'package:content_app/view/widget/customComponent.dart';
import 'package:content_app/view/screen/auth/forgetPassword.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../logic/controller/authC/authC.dart';

class Auth extends GetView<AuthController> {
  Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                  child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .30,
                  color: Color(0xff383232),
                  child: Center(
                    child: Text("مرحبا بك عزيزنا العميل",
                        style: Theme.of(context).textTheme.headline1),
                  ),
                ),
              )),
              Positioned(
                top: MediaQuery.of(context).size.height * .22,
                right: MediaQuery.of(context).size.width * .10,
                child: TabBar(
                  onTap: (value) => print(value),
                  indicatorColor: Color(0xff383232),
                  controller: controller.tabController,
                  isScrollable: true,
                  padding: EdgeInsets.only(left: 100, right: 50),
                  tabs: [
                    Tab(
                      child: Text("تسجيل دخول",
                          style: Theme.of(context).textTheme.headline4),
                    ),
                    Tab(
                        child: Text(" إنشاء حساب",
                            style: Theme.of(context).textTheme.headline4))
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 470,
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TabBarView(
                controller: controller.tabController,
                children: [singin(context), singup(context)]),
          ),
        ],
      )),
    );
  }

  singup(context) {
    return GetBuilder<AuthController>(
        builder: (controller) => Form(
              key: controller.RegisterformKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  textform(" الاسم", false, Icons.person, controller.name,
                      (value) {
                    return validInput(value!, 4, 20, 'username');
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  textform(
                      " الايميل", false, Icons.email, controller.emailRegister,
                      (value) {
                    return validInput(value!, 15, 30, "email");
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  textform(
                    " كلمة السر",
                    false,
                    Icons.password,
                    controller.passwordRegister,
                    (value) {
                      return validInput(value!, 6, 20, "password");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textform(
                    "  الهاتف",
                    false,
                    Icons.password,
                    controller.phone,
                    (value) {
                      return validInput(value!, 9, 9, "phone");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  textform(
                    " العنوان ",
                    false,
                    Icons.password,
                    controller.address,
                    (value) {
                      return validInput(value!, 3, 20, "");
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    controller.messageErrorRegister,
                    style: TextStyle(color: Colors.red),
                  ),
                  controller.statusreguest == StatusRequest.loading
                      ? Center(
                          child: Lottie.asset(
                              "assets/lottie/97443-loading-gray.json"))
                      : SizedBox(
                          width: 250,
                          child: button(" إنشاء حساب", () {
                            controller.registerUser();
                          }, context),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      controller.handleTabChange();
                    },
                    child: Text("هل لديك حساب مسبقا ؟ ",
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ],
              ),
            ));
  }

  singin(context) {
    print("singin()");
    return GetBuilder<AuthController>(
        builder: (controller) => Container(
              padding: EdgeInsets.only(top: 30),
              child: Form(
                key: controller.LoginformKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    textform(
                      " الايميل",
                      false,
                      Icons.email,
                      controller.emailLogin,
                      (value) {
                        return validInput(value!, 10, 30, "email");
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textform(
                      " كلمة السر",
                      false,
                      Icons.password,
                      controller.passwordLogin,
                      (value) {
                        return validInput(value!, 6, 20, "password");
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      controller.messageErrorLogin,
                      style: TextStyle(color: Colors.red),
                    ),
                    controller.statusreguest == StatusRequest.loading
                        ? Center(
                            child: Lottie.asset(
                                "assets/lottie/97443-loading-gray.json"))
                        : SizedBox(
                            width: 250,
                            child: button(" دخول", () {
                              // controller.message.value = '';

                              controller.loginUser();
                            }, context),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(ForgetPassword());
                      },
                      child: Text("هل نسيت كلمة السر ؟ ",
                          style: Theme.of(context).textTheme.bodyText1),
                    ),
                  ],
                ),
              ),
            ));
  }
}

// class Auth extends GetView<AuthController> {
//   const Auth({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Container(
//           color: Colors.white,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Stack(
//                   children: [
//                     Positioned(
//                         child: ClipPath(
//                       clipper: CustomClipPath(),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: MediaQuery.of(context).size.height * .40,
//                         color: Color(0xff383232),
//                         child: Center(
//                           child: Text("مرحبا بك عزيزنا العميل",
//                               style: Theme.of(context).textTheme.headline1),
//                         ),
//                       ),
//                     )),
//                     Positioned(
//                       // top: MediaQuery.of(context).size.height * .30,
//                       // right: MediaQuery.of(context).size.width * .10,
//                       child: TabBar(
//                         indicatorColor: Color(0xff383232),
//                         controller: controller.tabController,
//                         isScrollable: true,
//                         padding: EdgeInsets.only(left: 100, right: 50),
//                         tabs: [
//                           Tab(
//                             child: Text("تسجيل دخول",
//                                 style: Theme.of(context).textTheme.headline4),
//                           ),
//                           Tab(
//                               child: Text(" إنشاء حساب",
//                                   style: Theme.of(context).textTheme.headline4))
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 Container(
//                   height: 400,
//                   padding: const EdgeInsets.all(30),
//                   child: TabBarView(
//                       controller: controller.tabController,
//                       children: [singin(context), singup(context)]),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }

//   singup(context) {
//     return Form(
//       key: controller.RegisterformKey,
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           textform(" الاسم", false, Icons.person, controller.name, (value) {
//             return validInput(value!, 4, 20, 'username');
//           }),
//           SizedBox(
//             height: 10,
//           ),
//           textform(" الايميل", false, Icons.email, controller.emailRegister,
//               (value) {
//             return validInput(value!, 20, 30, "email");
//           }),
//           SizedBox(
//             height: 10,
//           ),
//           textform(
//             " كلمة السر",
//             false,
//             Icons.password,
//             controller.passwordRegister,
//             (value) {
//               return validInput(value!, 15, 100, "password");
//             },
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             width: 250,
//             child: button(" إنشاء حساب", () {
//               print("ddd");
//             }, context),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           InkWell(
//             onTap: () {},
//             child: Text("هل لديك حساب مسبقا ؟ ",
//                 style: Theme.of(context).textTheme.bodyText1),
//           ),
//         ],
//       ),
//     );
//   }

//   singin(context) {
//     print("singin()");
//     return Container(
//       // height: MediaQuery.of(context).size.height - 700,
//       child: Form(
//         key: controller.LoginformKey,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             textform(
//               " الايميل",
//               false,
//               Icons.email,
//               controller.emailLogin,
//               (value) {
//                 return validInput(value!, 10, 30, "email");
//               },
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             textform(
//               " كلمة السر",
//               false,
//               Icons.password,
//               controller.passwordLogin,
//               (value) {
//                 return validInput(value!, 6, 10, "password");
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             GetX<AuthController>(
//               builder: (item) => Text(
//                 controller.message.value,
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//             SizedBox(
//               width: 250,
//               child: button(" دخول", () {
//                 // controller.message.value = '';
//                 controller.loginUser();
//               }, context),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             InkWell(
//               onTap: () {
//                 Get.to(ResetPassword());
//               },
//               child: Text("هل نسيت كلمة السر ؟ ",
//                   style: Theme.of(context).textTheme.bodyText1),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
