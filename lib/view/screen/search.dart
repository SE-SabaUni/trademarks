import 'package:content_app/logic/controller/searchC.dart';
import 'package:content_app/services/Crud.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../widget/customComponent.dart';
import 'trademark/detailes.dart';

class Search extends GetView<searchController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                  child: ClipPath(
                clipper: CustomClipPath(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .35,
                  color: Color(0xff383232),
                ),
              )),
              Positioned(
                  child: Container(
                padding: EdgeInsets.all(40),
                width: MediaQuery.of(context).size.width,
                child: GetBuilder<searchController>(
                    builder: (builder) => TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: controller
                              .dateinput, //editing controller of this TextField
                          decoration: InputDecoration(
                            hintText: "ادخل التاريخ",
                            hintStyle: Theme.of(context).textTheme.bodyText2,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 5,
                                  color: Color(0xffA89B93)), //<-- SEE HERE
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            focusedBorder: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              borderSide: BorderSide(
                                  width: 5, color: Color(0xffA89B93)),
                            ),
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Color(0xffA89B93),
                            ), //icon of text field
                          ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            controller.pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101),
                                builder: ((context, child) => Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary:
                                              Color(0xff7F7671), // <-- SEE HERE
                                        ),
                                      ),
                                      child: child!,
                                    )));

                            if (controller.pickedDate != null) {
                              //pickedDate output format => 2021-03-10 00:00:00.000
                              controller.formattedDate =
                                  DateFormat('yyyy-MM-dd')
                                      .format(controller.pickedDate!);
                              //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              controller.dateinput.text =
                                  controller.formattedDate;
                            } else {
                              print("Date is not selected");
                            }
                          },
                        )),
              )),
              Positioned(
                top: MediaQuery.of(context).size.height * .25,
                right: MediaQuery.of(context).size.width * .30,
                child: SizedBox(
                  width: 250,
                  child: button(" بحث", () {}, context),
                ),
              )
            ],
          ),

          ///////////////////////////////////////
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, i) => Container(
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Color(0xfff7f2e8),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(6, 7),
                            blurRadius: 10,
                            color: Color(0xffA89B93).withOpacity(0.8),
                          )
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.to(Detailes());
                        },
                        title: Text(
                          "مايكروسوفت",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        leading: Icon(
                          Icons.image,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        subtitle: Text(
                          "20-12-2022",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: Icon(Icons.arrow_circle_left))
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
