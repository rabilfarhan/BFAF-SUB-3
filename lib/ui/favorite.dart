import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/card_item.dart';
import 'package:restaurant_app/utils/request_state.dart';

class Favorite extends StatelessWidget {
  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == RequestState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardListRestaurant(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(child: Text("Data Not Found"));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Text('Favorite Restaurant'),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 8),
        child: _buildList(),
      ),
    );
  }
}
