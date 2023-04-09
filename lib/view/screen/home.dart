import 'package:cached_network_image/cached_network_image.dart';
import 'package:content_app/logic/controller/HomeC.dart';
import 'package:content_app/logic/controller/homeSearchC.dart';
import 'package:content_app/services/statusRequst.dart';
import 'package:content_app/utils/linkApi.dart';
import 'package:content_app/view/screen/drawer.dart';
import 'package:content_app/view/widget/customComponent.dart';

import 'package:content_app/view/screen/trademark/detailes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              "assets/images/al-alama-removebg-preview.png",
              alignment: Alignment.centerRight,
              height: 70,
              width: 70,
            ),
            elevation: 0.0,
          ),
          drawer: CustomDrawer(),
          body: GetBuilder<HomeController>(
            builder: (controller) => RefreshIndicator(
                color: Color(0xff7F7671),
                onRefresh: controller.refreshData,
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          bottom: 10, top: 10, left: 10, right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xff383232),
                          border: Border.all(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          showSearch(
                              context: context,
                              // delegate to customize the search bar
                              delegate: CustomSearchDelegate());
                        },
                        child: Text(
                          "بحث",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                    controller.statusRequest == StatusRequest.offlinefailure
                        ? lottieOfLine()
                        : controller.statusRequest ==
                                StatusRequest.serverfailure
                            ? lottieServerFaliuer()
                            : ListView.builder(
                                controller: controller.scrollController,
                                shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.data.length + 1,
                                itemBuilder: (context, i) => i <
                                        controller.data.length
                                    ? Container(
                                        margin: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Color(0xfff7f2e8),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(30),
                                                    bottomLeft:
                                                        Radius.circular(30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    offset: Offset(6, 7),
                                                    blurRadius: 10,
                                                    color: Color(0xffA89B93)
                                                        .withOpacity(0.8),
                                                  )
                                                ],
                                              ),
                                              child: ListTile(
                                                onTap: () {
                                                  controller
                                                      .goToDatailsScreen(i);
                                                },
                                                title: Text(
                                                  "${controller.data[i]['name']}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                                leading: ClipOval(
                                                  child: CachedNetworkImage(
                                                    height: 30,
                                                    width: 30,
                                                    imageUrl:
                                                        "$linkimageRoot${controller.data[i]['image']}",
                                                    placeholder: (context,
                                                            url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              child: IconButton(
                                            icon: Icon(Icons.arrow_circle_left),
                                            onPressed: () {
                                              controller.goToDatailsScreen(i);
                                            },
                                          ))
                                        ]),
                                      )
                                    : lottieLoading())
                  ],
                )),
          )),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  HomeSearchController controller = Get.put(HomeSearchController());
  @override
  String get searchFieldLabel => 'بحث';

// Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  List sugusstion = ['roqiah', 'somiah', 'sami'];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(
          Icons.clear,
        ),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
      ),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    print("build result");
    controller.searchApi(query);

    sugusstion.add(query);

    return GetBuilder<HomeSearchController>(
        builder: (controller) =>
            controller.statusRequest == StatusRequest.loading
                ? lottieLoading()
                : controller.statusRequest == StatusRequest.failure
                    ? Text(
                        "noooooodata",
                        style: Theme.of(context).textTheme.headline5,
                      )
                    : ListView.builder(
                        itemCount: controller.matchQuery.length,
                        itemBuilder: (context, index) {
                          var result = controller.matchQuery[index];
                          return ListTile(
                            title: InkWell(
                              child: Text(
                                result,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              onTap: () {},
                            ),
                          );
                        },
                      ));
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery2 = [];
    print("build suggestion");
    for (var fruit in sugusstion) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery2.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery2.length,
      itemBuilder: (context, index) {
        var result = matchQuery2[index];
        return ListTile(
          title: Text(
            result,
            style: TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}
