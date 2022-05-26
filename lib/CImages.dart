import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

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
            Text(tr('convenient_store'),
                textAlign: TextAlign.center,
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
            Text(tr('atm'),
                textAlign: TextAlign.center,
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
            Text(tr('post_office'),
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
            Text(tr('stationery_store'),
                textAlign: TextAlign.center,
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
            Text(tr('exercise'),
                textAlign: TextAlign.center,
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
            Text(tr('strawberry'),
                textAlign: TextAlign.center,
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
            Text(tr('cafeteria'),
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
            Text(tr('printer'),
                textAlign: TextAlign.center,
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
            Text(tr('cafe'),
                textAlign: TextAlign.center,
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
            Text(tr('blood'),
                textAlign: TextAlign.center,
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
