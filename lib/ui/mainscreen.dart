import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider_list.dart';
import 'package:restaurant_app/ui/favorite.dart';
import 'package:restaurant_app/utils/request_state.dart';
import 'package:restaurant_app/ui/card_item.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Widget _buildList() {
      return ChangeNotifierProvider(
        create: (_) => RestaurantListProvider(
          apiService: ApiService(Client()),
        ),
        child: Consumer<RestaurantListProvider>(
          builder: (context, state, _) {
            if (state.state == RequestState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == RequestState.HasData) {
              return _buildBody(context, state);
            } else if (state.state == RequestState.NoData) {
              return Center(
                child: Text(state.message),
              );
            } else if (state.state == RequestState.Error) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text(''),
              );
            }
          },
        ),
      );
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Favorite();
            }));
          },
          backgroundColor: Colors.red,
          child: const Icon(Icons.favorite),
        ),
        body: _buildList(),
        backgroundColor: Colors.blueGrey);
  }

  SafeArea _buildBody(BuildContext context, RestaurantListProvider state) {
    return SafeArea(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            height: 48.0,
                            width: 48.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                              image: DecorationImage(
                                image: AssetImage('images/boy_person.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return CardListRestaurant(
                restaurant: state.result!.restaurants[index],
              );
            },
            itemCount: state.result!.restaurants.length,
          ),
        ],
      ),
    );
  }
}
