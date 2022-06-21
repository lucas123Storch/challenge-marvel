import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:marvel_challenge/customIcons.dart';
import 'package:http/http.dart' as http;
import 'package:marvel_challenge/pages/detail_page.dart';
import 'package:marvel_challenge/widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

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
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, top: 30.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        CustomIcons.menu,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Marvel",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 46.0,
                        fontFamily: "Calibre-Semibold",
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Center(
                    child: FutureBuilder(
                      future: getCharacters(),
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
                            return Container(
                              margin: EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              height: MediaQuery.of(context).size.height,
                              child: ListView.builder(
                                itemCount: (snapshot.data as List).length,
                                itemBuilder: (context, index) {
                                  var element = (snapshot.data as List)[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Detailpage(
                                                id: element["id"],
                                                name: element["name"],
                                              ),
                                            ),
                                          ),
                                        },
                                        child: CardWidget(
                                          name: element["name"],
                                          thumb:
                                              '${element['thumbnail']['path']}.${element['thumbnail']['extension']}',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        } else {
                          return CircularProgressIndicator();
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

  Future<List> getCharacters() async {
    try {
      var url = Uri.parse(
          'http://gateway.marvel.com/v1/public/characters?ts=1&apikey=690e3ac16286c2de4591eca37269eedb&hash=fcbd875beb64e407e41ea8088ed2cd0c');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        var res = json.decode(response.body);
        var arr = res["data"]["results"];
        return arr;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
