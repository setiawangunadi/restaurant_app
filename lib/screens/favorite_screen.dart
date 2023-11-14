import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/favorite/favorite_bloc.dart';
import 'package:restaurant_app/config/data/local/constants.dart';
import 'package:restaurant_app/config/models/favorite_restaurant.dart';
import 'package:restaurant_app/routers.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteBloc favoriteBloc;
  List<FavoriteRestaurant> listFavorite = [];

  @override
  void initState() {
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(GetFavoriteRestaurant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteBloc, FavoriteState>(
      listener: (context, state) {
        if (state is OnSuccessGetListFavorite) {
          setState(() {
            listFavorite = state.listRestaurant;
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("List Favorite"),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routers.home),
              child: const Icon(Icons.arrow_back),
            ),
          ),
          body: state is OnLoadingFavorite
              ? Shimmer.fromColors(
                  direction: ShimmerDirection.ltr,
                  period: const Duration(milliseconds: 1200),
                  baseColor: Colors.grey.withOpacity(0.5),
                  highlightColor: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 78,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Favorite Restaurant",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        "List favorite restaurant for you!",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.8 - 2,
                        child: ListView.builder(
                          itemCount: listFavorite.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routers.detail,
                                arguments: [listFavorite[index].id, "favorite"],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                margin: const EdgeInsets.only(top: 16.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Image.network(
                                      "$baseUrlImage/${listFavorite[index].pictureId}",
                                      width: 100,
                                    ),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listFavorite[index].name ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on_outlined,
                                              size: 16,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                                listFavorite[index].city ?? ""),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
