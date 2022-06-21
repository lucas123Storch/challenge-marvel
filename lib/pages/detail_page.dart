import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_challenge/widgets/lists_widget.dart';

class Detailpage extends StatefulWidget {
  const Detailpage({Key? key, required this.id, required this.name}) : super(key: key);

  final int id;
  final String name;

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1b1e44),
            Color(0xFF2d3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Color(0x44000000),
        elevation: 0,
        title: Text(widget.name),
      ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child: FutureBuilder(
                      future: getCharacter(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                '${snapshot.error}',
                                style: TextStyle(fontSize: 18),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            var element = snapshot.data as Map;
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              child: ListView(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .4,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                '${element['thumbnail']['path']}.${element['thumbnail']['extension']}'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Comics: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 46.0,
                                            fontFamily: "Calibre-Semibold",
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                      ),
                                      ListWidgets(element: element["comics"]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 1,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Series: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 46.0,
                                            fontFamily: "Calibre-Semibold",
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                      ),
                                      ListWidgets(element: element["series"]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 1,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: 20,
                                          top: 20,
                                        ),
                                        child: Text(
                                          "Stories: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 46.0,
                                            fontFamily: "Calibre-Semibold",
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                      ),
                                      ListWidgets(element: element["stories"]),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 150,)
                                ],
                              ),
                            );
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> getCharacter() async {
    var id = widget.id;
    try {
      var url = Uri.parse(
          'http://gateway.marvel.com/v1/public/characters/${id}?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        var res = json.decode(response.body);
        var arr = res["data"]["results"];
        return arr[0];
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
