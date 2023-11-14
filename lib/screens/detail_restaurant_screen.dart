import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail_restaurant/detail_restaurant_bloc.dart';
import 'package:restaurant_app/config/data/local/constants.dart';
import 'package:restaurant_app/config/models/detail_restaurant_response.dart';
import 'package:restaurant_app/routers.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String id;
  final String type;

  const DetailRestaurantScreen({
    super.key,
    required this.id,
    required this.type,
  });

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  late DetailRestaurantBloc detailRestaurantBloc;
  DetailRestaurantResponse? detailRestaurantResponse;

  @override
  void initState() {
    detailRestaurantBloc = BlocProvider.of<DetailRestaurantBloc>(context);
    detailRestaurantBloc.add(GetDetailRestaurant(id: widget.id));
    super.initState();
  }

  goFavorite() async {
    await Navigator.pushNamed(context, Routers.favorite);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailRestaurantBloc, DetailRestaurantState>(
      listener: (context, state) async {
        if (state is OnSuccessGetDetailRestaurant) {
          setState(() {
            detailRestaurantResponse = state.detailRestaurantResponse;
          });
        }
        if (state is OnSuccessAddFavorite) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
        if (state is OnSuccessDeleteFavorite) {
          goFavorite();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Detail Restaurant"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        "$baseUrlImage/${detailRestaurantResponse?.restaurant?.pictureId}"),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detailRestaurantResponse
                                              ?.restaurant?.name ??
                                          "",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on_outlined,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          detailRestaurantResponse
                                                  ?.restaurant?.address ??
                                              "",
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          detailRestaurantResponse
                                                  ?.restaurant?.city ??
                                              "",
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  shape: BoxShape.circle,
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 32,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      detailRestaurantResponse
                                              ?.restaurant?.rating
                                              .toString() ??
                                          "",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            detailRestaurantResponse?.restaurant?.description ??
                                "",
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Categories",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ListView.builder(
                              itemCount: detailRestaurantResponse
                                  ?.restaurant?.categories?.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_circle_right_rounded,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(detailRestaurantResponse?.restaurant
                                            ?.categories?[index].name ??
                                        ""),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          foodMenu(),
                          const SizedBox(height: 8),
                          drinkMenu(),
                          const SizedBox(height: 8),
                          const Text(
                            "Customer Reviews",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.2,
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: detailRestaurantResponse
                                  ?.restaurant?.customerReviews?.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  padding: const EdgeInsets.all(16.0),
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: Colors.black)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        detailRestaurantResponse
                                                ?.restaurant
                                                ?.customerReviews?[index]
                                                .name ??
                                            "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(detailRestaurantResponse?.restaurant
                                              ?.customerReviews?[index].date ??
                                          ""),
                                      Text(
                                        detailRestaurantResponse
                                                ?.restaurant
                                                ?.customerReviews?[index]
                                                .review ??
                                            "",
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => detailRestaurantBloc.add(
              widget.type == "home"
                  ? DoFavoriteRestaurant(
                      detailRestaurantResponse: detailRestaurantResponse ??
                          DetailRestaurantResponse(),
                    )
                  : DoDeleteRestaurant(
                      id: widget.id,
                    ),
            ),
            backgroundColor: Colors.red,
            child: Icon(widget.type == "home" ? Icons.favorite : Icons.delete),
          ),
        );
      },
    );
  }

  Widget foodMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Food Menu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                detailRestaurantResponse?.restaurant?.menus?.foods?.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.food_bank_outlined,
                      size: 64,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detailRestaurantResponse
                              ?.restaurant?.menus?.foods?[index].name ??
                          "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget drinkMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Drink Menu",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount:
                detailRestaurantResponse?.restaurant?.menus?.foods?.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.water_drop_outlined,
                      size: 64,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      detailRestaurantResponse
                              ?.restaurant?.menus?.drinks?[index].name ??
                          "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
