import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/detail_restaurant/detail_restaurant_bloc.dart';
import 'package:restaurant_app/config/data/local/constants.dart';
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
        if (state is OnSuccessAddFavorite) {
          Navigator.pushNamed(context, Routers.home);
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
        if (state is OnFailedDetailRestaurant) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is OnSuccessGetDetailRestaurant)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                          "$baseUrlImage/${state.detailRestaurantResponse.restaurant?.pictureId}"),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.detailRestaurantResponse
                                                .restaurant?.name ??
                                            "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              state.detailRestaurantResponse
                                                      .restaurant?.address ??
                                                  "",
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              state.detailRestaurantResponse
                                                      .restaurant?.city ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12.0),
                                  margin: const EdgeInsets.all(4.0),
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
                                        state.detailRestaurantResponse
                                                .restaurant?.rating
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
                              state.detailRestaurantResponse.restaurant
                                      ?.description ??
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
                                itemCount: state.detailRestaurantResponse
                                    .restaurant?.categories?.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      const Icon(
                                        Icons.arrow_circle_right_rounded,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(state
                                              .detailRestaurantResponse
                                              .restaurant
                                              ?.categories?[index]
                                              .name ??
                                          ""),
                                    ],
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            foodMenu(state),
                            const SizedBox(height: 8),
                            drinkMenu(state),
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
                              height: MediaQuery.of(context).size.height * 0.25,
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.detailRestaurantResponse
                                    .restaurant?.customerReviews?.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border:
                                            Border.all(color: Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state
                                                  .detailRestaurantResponse
                                                  .restaurant
                                                  ?.customerReviews?[index]
                                                  .name ??
                                              "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(state
                                                .detailRestaurantResponse
                                                .restaurant
                                                ?.customerReviews?[index]
                                                .date ??
                                            ""),
                                        Text(
                                          state
                                                  .detailRestaurantResponse
                                                  .restaurant
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
                if (state is OnFailedDetailRestaurant) Text(state.message),
                if (state is OnLoadingDetailRestaurant)
                  const Center(child: CircularProgressIndicator())
              ],
            ),
          ),
          floatingActionButton: state is OnSuccessGetDetailRestaurant
              ? FloatingActionButton(
                  onPressed: () => detailRestaurantBloc.add(
                    widget.type == "home"
                        ? DoFavoriteRestaurant(
                            detailRestaurantResponse:
                                state.detailRestaurantResponse,
                          )
                        : DoDeleteRestaurant(
                            id: widget.id,
                          ),
                  ),
                  backgroundColor: Colors.red,
                  child: Icon(
                      widget.type == "home" ? Icons.favorite : Icons.delete),
                )
              : null,
        );
      },
    );
  }

  Widget foodMenu(OnSuccessGetDetailRestaurant state) {
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
                state.detailRestaurantResponse.restaurant?.menus?.foods?.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.all(8.0),
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
                      state.detailRestaurantResponse.restaurant?.menus
                              ?.foods?[index].name ??
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

  Widget drinkMenu(OnSuccessGetDetailRestaurant state) {
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
                state.detailRestaurantResponse.restaurant?.menus?.foods?.length,
            itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.all(8.0),
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
                      state.detailRestaurantResponse.restaurant?.menus
                              ?.drinks?[index].name ??
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
