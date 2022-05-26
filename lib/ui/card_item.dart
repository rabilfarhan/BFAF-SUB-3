import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/list_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/detailscreen.dart';
import 'package:restaurant_app/utils/style.dart';

class CardListRestaurant extends StatefulWidget {
  final Restaurants restaurant;

  const CardListRestaurant({required this.restaurant});

  @override
  State<CardListRestaurant> createState() => _CardListRestaurantState();
}

class _CardListRestaurantState extends State<CardListRestaurant> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(widget.restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return RestaurantDetailPage(
                      id: widget.restaurant.id,
                    );
                  }),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10, top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Container(
                    height: 270,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '$IMAGE_BASE_URL${widget.restaurant.pictureId}'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                child: isFavorited
                                    ? IconButton(
                                        onPressed: () =>
                                            provider.removeFavorite(
                                                widget.restaurant.id),
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 30,
                                        ),
                                        color: Colors.red)
                                    : IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 30,
                                        ),
                                        color: Colors.white,
                                        onPressed: () => provider
                                            .addFavorites(widget.restaurant),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.restaurant.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                widget.restaurant.description,
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.room,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    widget.restaurant.city,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    widget.restaurant.rating.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    });
  }
}
