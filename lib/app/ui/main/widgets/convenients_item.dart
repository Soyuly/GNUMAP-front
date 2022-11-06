import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gnumap/app/ui/convenients/Convenience.dart';

class ConvenientsItem extends StatelessWidget {
  final title;
  final name;
  const ConvenientsItem({Key? key, required this.title, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        onTap: () {
          Get.toNamed('/convenient', arguments: {
            "category": title,
            "name": name,
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
                        image: AssetImage('assets/convenient/$name.jpg')),
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
