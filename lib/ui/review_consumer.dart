
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

class ReviewCustomer extends StatelessWidget {
  const ReviewCustomer({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text('Review Customer'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: restaurant.customerReviews.map(
            (review) {
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          review.review,
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          review.date,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
