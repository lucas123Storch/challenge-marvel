import 'package:flutter/material.dart';

class ListWidgets extends StatelessWidget {
  final element;
  const ListWidgets({Key? key, this.element}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      height: MediaQuery.of(context).size.height * .3,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: element["available"],
        itemBuilder: (context, index) {
          var item = element["items"][index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '- ${item["name"]}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
