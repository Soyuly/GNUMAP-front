import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Expanded(
                      flex: 12,
                      child: Image.asset('assets/intro.png', width: 500)),
                  Expanded(
                      flex: 1,
                      child: Text(
                        '학교 공용 와이파이로 접속이 불가능합니다. \n 그누맵 사용 시 데이터 사용을 권장합니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Pretendard', color: Color(0xff767676)),
                      ))
                ]))));
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) {
      Get.offAllNamed("/main");
    });
  }
}
