import 'package:flutter/material.dart';

class ConvenientItems_top extends StatelessWidget {
  const ConvenientItems_top({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/convenient/convenientstore.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('편의점',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/atm.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('ATM',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/postoffice.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('우체국',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/stationary.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('문구점',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/aed.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('AED',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
    ]);
  }
}

class ConvenientItems_bottom extends StatelessWidget {
  const ConvenientItems_bottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/strawberry.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('딸기방',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/cafeteria.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('식당',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/printer.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('프린터',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/cafe.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('카페',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
      SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/convenient/blood.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text('헌혈의집',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontFamily: 'AppleSDGothicNeo'))
          ],
        ),
      ),
    ]);
  }
}
