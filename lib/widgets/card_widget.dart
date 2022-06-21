import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  CardWidget({
    Key? key,
    this.thumb,
    this.name,
  }) : super(
          key: key,
        );

  final thumb;
  final name;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3.0, 6.0),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(
                40.0,
              ),
              topRight: const Radius.circular(
                40.0,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * .2,
                child: Image.network(
                  thumb,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Calibre-Semibold",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
