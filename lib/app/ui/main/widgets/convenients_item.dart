import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/convenients/Convenience.dart';

class ConvenientsItem extends StatelessWidget {
  final api;
  final name;
  final title;
  final appbar;
  const ConvenientsItem(
      {Key? key,
      required this.api,
      required this.title,
      required this.name,
      required this.appbar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/convenient', arguments: {
            "category": api,
            "name": name,
            "title": title,
            "appbar": appbar,
          });
        },
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
                        image: AssetImage('assets/icons/$name.jpg')),
                    borderRadius: BorderRadius.circular(50),
                  )),
            ),
            Text(title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4)
          ],
        ),
      ),
    );
  }
}
