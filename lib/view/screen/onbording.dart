import 'package:content_app/view/screen/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:introduction_slider/introduction_slider.dart';

import '../widget/customComponent.dart';

class Onbording extends StatelessWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionSlider(
        items: [
          slider(context, "assets/images/trademark-removebg-preview.png",
              "بخدمتكم لانة واجبنا"),
          slider(context, "assets/images/download-removebg-preview.png",
              "تسهيل اجراءات تسجيل العلامة التجارية"),
          slider(
              context,
              "assets/images/intellectual-property-patented-protection-copyright-reserved-or-product-trademark-that-cannot-copy-concept-vector-removebg-preview.png",
              " حماية الحقوق وممارسة الامان")
        ],
        done: Done(
          child: Icon(Icons.done, color: Color(0xff383232)),
          home: Auth(),
        ),
        next: Next(
            child: Icon(
          Icons.arrow_forward,
          color: Color(0xff383232),
        )),
        back: Back(
            child: Icon(
          Icons.arrow_back,
          color: Color(0xff383232),
        )),
        dotIndicator: DotIndicator(selectedColor: Color(0xff383232)),
      ),
    );
  }
}
