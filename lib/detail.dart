import 'package:flutter/material.dart';
import 'package:restaurant/model/RestaurantModel.dart';

class DetailScreen extends StatelessWidget {
  final RestaurantModel restaurant;

  const DetailScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailScreenPage(restaurant: restaurant);
  }
}

class DetailScreenPage extends StatelessWidget {
  final RestaurantModel restaurant;

  const DetailScreenPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: restaurant.id,
                  child: Image.network(restaurant.pictureUrl),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                restaurant.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Staatliches',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.pin_drop),
                      const SizedBox(height: 8.0),
                      Text(
                        restaurant.city,
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.star),
                      const SizedBox(height: 8.0),
                      Text(
                        restaurant.rating.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                restaurant.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontFamily: 'Oxygen',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
              child: Text(
                "Foods",
                style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: restaurant.menu.foods.map((menuItem) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Image.network("https://ui-avatars.com/api/?name=" +
                                  menuItem.name +
                                  "&color=7F9CF5&background=EBF4FF&size=80&format=png"),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(menuItem.name),
                              Text("Rp. " + (menuItem.price ?? 0).toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 16.0),
              child: Text(
                "Drinks",
                style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: restaurant.menu.drinks.map((menuItem) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Image.network( menuItem.pictureUrl ??
                                  "https://ui-avatars.com/api/?name=" +
                                      menuItem.name +
                                      "&color=7F9CF5&background=EBF4FF&size=80&format=png"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(menuItem.name),
                              Text("Rp. " + (menuItem.price ?? 0).toString()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}