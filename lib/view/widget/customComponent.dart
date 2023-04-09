import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:content_app/utils/Themes.dart';
import 'package:flutter/material.dart';
import 'package:introduction_slider/source/presentation/widgets/introduction_slider_item.dart';
import 'package:lottie/lottie.dart';

Gradient customGradient() {
  return const LinearGradient(colors: [
    Color.fromARGB(255, 38, 33, 33),
    //Color(0xff383232),
    Color.fromARGB(255, 127, 115, 107),

    //Color(0xff383232)

    //Color(0xffC6C1BE),
    // Color(0xffC6C1BE),
  ], begin: Alignment.topLeft, end: Alignment.bottomRight);
  ;
}

/////////////// for listTile in drawer
listTile(context, String title, IconData icon, Function() fun) {
  return ListTile(
    leading: Icon(
      icon,
      color: Color(0xff7F7671),
    ),
    title: Text(
      "$title",
      style: Theme.of(context).textTheme.headline2,
    ),
    onTap: fun,
  );
}

////////////with icon
TextFormField textform(
    String hint,
    bool state,
    IconData icon,
    TextEditingController textcontroller,
    String? Function(String?) textvalidate) {
  return TextFormField(
    style: TextStyle(
      color: Colors.black,
      fontSize: 17,
    ),
    cursorColor: Color(0xff7F7671),
    //  textAlign: TextAlign.start,
    obscureText: state,
    controller: textcontroller,
    validator: textvalidate,
    // autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      hintText: hint,

      hintStyle: const TextStyle(color: Color(0xff7F7671)),
      prefixIcon: Icon(
        icon,
        // color: Color(0xff383232),
      ),
      // focusedBorder: const UnderlineInputBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(50)),
      //   borderSide: BorderSide(width: 5, color: Color(0xff383232)),
      // ),
      // enabledBorder: UnderlineInputBorder(
      //   borderSide: const BorderSide(
      //     width: 5,
      //   ), //<-- SEE HERE
      //   borderRadius: BorderRadius.circular(50.0),
      // )
    ),
  );
}

//custom button
Container button(hint, void Function()? fun, context) {
  return Container(
    margin: EdgeInsets.all(10),
    padding: EdgeInsets.all(10),
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        color: Color(0xff383232),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            offset: Offset(6, 7),
            blurRadius: 5,
            color: Color(0xffA89B93).withOpacity(0.8),
          ),
        ]),
    child: InkWell(
      onTap: fun,
      child: Text(
        '$hint',
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

/////////////////////////////////
///
class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width, 0);
    path0.quadraticBezierTo(size.width * 1.0016667, size.height * 0.1350000,
        size.width, size.height * 0.3750000);
    path0.cubicTo(size.width * 0.9550000, size.height * 1.0650000,
        size.width * 0.0383333, size.height * 0.2550000, 0, size.height);
    path0.quadraticBezierTo(0, size.height * 0.6300000, 0, 0);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

////////////////////////////
// onbording
slider(context, String image, String text) {
  return IntroductionSliderItem(
    logo: Image.asset("$image"),
    title: Text("$text", style: Theme.of(context).textTheme.headline4),
  );
}

//////////
///app bar
appBar(context, String text) {
  return AppBar(
    title: Column(
      children: [
        Image.asset(
          "assets/images/al-alama-removebg-preview.png",
          alignment: Alignment.centerRight,
          height: 50,
          width: 50,
        ),
        Text(
          "$text",
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    ),
    titleSpacing: 00.0,
    centerTitle: true,
    toolbarHeight: 80.2,
    toolbarOpacity: 0.8,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
    ),
    elevation: 0.0,
  );
}

/////////
///botomBar
bottomBarItem(String text, IconData icon) {
  return BottomNavyBarItem(
      inactiveColor: Color(0xff383232),
      activeColor: Color(0xffA89B93),
      title: Text('$text'),
      icon: Icon(icon));
}

////
///dropdown
dropdown(String hint, context, Object? selectedValue, List? item) {
  return Row(
    children: [
      Expanded(
          flex: 1,
          child: Text(
            " $hint",
            style: Theme.of(context).textTheme.headline5,
          )),
      Expanded(
        flex: 2,
        child: DropdownButtonFormField(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            alignment: Alignment.bottomLeft,
            dropdownColor: Colors.white,
            value: selectedValue,
            items: item!.map((cat) {
              return DropdownMenuItem(
                child: Text(
                  cat['name'],
                  style: TextStyle(color: Colors.black),
                ),
                value: cat['id'],
              );
            }).toList(),
            onChanged: (value) {
              selectedValue = value;
              print(selectedValue);
            },
            validator: (value) =>
                value == null ? 'الحقل لايمكن ان يكون فارغ' : null),
      ),
    ],
  );
}

/////////
///row in update trademark and ....
row(String text, TextEditingController controller,
    String? Function(String?) textvalidate, context) {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Text(
          " $text ",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      Expanded(
          flex: 2,
          child: TextFormField(
              style: TextStyle(color: Colors.black),
              controller: controller,
              validator: textvalidate,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xff7F7671),
                  )))))
    ],
  );
}

/////////////
///to choose date
datefield(context, TextEditingController? dateInput, String text, controller,
    int num, String? Function(String?)? validat) {
  return Row(
    children: [
      Expanded(
          flex: 1,
          child: Text(
            "$text",
            style: Theme.of(context).textTheme.headline5,
          )),
      Expanded(
        flex: 2,
        child: TextFormField(
          validator: validat,
          controller: dateInput, //editing controller of this TextField
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: const BorderSide(
                  width: 5, color: Color(0xff383232)), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(width: 5, color: Color(0xff383232)),
            ),
            icon: const Icon(
              Icons.calendar_today,
              color: Color(0xff383232),
            ), //icon of text field
          ),
          readOnly: true, //set it true, so that user will not able to edit text
          onTap: () async {
            num == 1
                ? controller.pickAddDate(context)
                : num == 2
                    ? controller.pickExpierDate(context)
                    : null;
          },
        ),
      ),
    ],
  );
}

//////////////////////////////////////////
lottieLoading() {
  return Center(child: Lottie.asset("assets/lottie/97443-loading-gray.json"));
}

lottieOfLine() {
  return Center(
      child: Lottie.asset(
    "assets/lottie/120901-no-connection.json",
  ));
}

lottieServerFaliuer() {
  return Center(child: Lottie.asset("assets/lottie/79736-web-server.json"));
}
