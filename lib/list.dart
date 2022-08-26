import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant/detail.dart';
import 'package:restaurant/model/RestaurantModel.dart';

var informationTextStyle = TextStyle(fontFamily: 'Oxygen');

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: RestaurantList(),
      ),
    );
  }
}

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  // Create an instance variable.
  List<RestaurantModel> _restaurantList = [];
  List<RestaurantModel> items = [];
  late final Future? readJsonFuture;

  @override
  void initState() {
    super.initState();

    readJsonFuture = _readJson();
  }

  // Fetch content from the json file
  Future<void> _readJson() async {
    final response = await http.get(Uri.parse('http://localhost:3000/restaurants'));
    // then parse the JSON.
    final payload = jsonDecode(response.body);
    setState(() {
      _restaurantList =
          (payload as List<dynamic>)
              .map((e) => RestaurantModel.fromJson(e))
              .toList();
      items.addAll(_restaurantList);
    });
  }

  void filterSearchResults(String query) {
    List<RestaurantModel> dummySearchList = [];
    dummySearchList.addAll(_restaurantList);
    if(query.isNotEmpty) {
      List<RestaurantModel> dummyListData = [];
      for (var item in dummySearchList) {
        if(item.name.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_restaurantList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readJsonFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Restaurant',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: 'Staatliches',
                      ),
                    ),
                    const Text(
                        'Recomendation restaurant for you',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'Staatliches',
                        )
                    ),
                    const SizedBox(height: 10,),
                    TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Type Restaurant's name",
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (text) {
                        filterSearchResults(text);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                items.isNotEmpty ?
                ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailScreen(restaurant: items[index],)),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Hero(
                                    tag: items[index].id,
                                    child: Image.network(
                                      items[index].pictureUrl,
                                      fit: BoxFit.cover,
                                      height: 90.0,
                                    )
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                        text: TextSpan(
                                          text: items[index].name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                    ),
                                    SizedBox(height: 5),
                                    Wrap(
                                      children: <Widget>[
                                        const Icon(Icons.location_on, size: 11),
                                        Text(
                                          items[index].city,
                                          style: const TextStyle(
                                            fontSize: 11.0,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Wrap(
                                      children: <Widget>[
                                        const Icon(Icons.star, size: 11),
                                        Text(
                                            items[index].rating.toString(),
                                            style: const TextStyle(
                                              fontSize: 11.0,
                                            )
                                        )
                                      ],
                                    )
                                  ],
                              )
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                )
                    : Text("no data"),
              )
            ],
          );
        }
    );
  }
}
