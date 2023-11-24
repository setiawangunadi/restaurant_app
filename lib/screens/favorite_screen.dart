import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/favorite/favorite_bloc.dart';
import 'package:restaurant_app/config/data/local/constants.dart';
import 'package:restaurant_app/routers.dart';
import 'package:shimmer/shimmer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteBloc favoriteBloc;

  @override
  void initState() {
    favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    favoriteBloc.add(GetFavoriteRestaurant());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            Navigator.pushNamed(context, Routers.home);
          },
          child: Scaffold(
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
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Favorite Restaurant",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "List favorite restaurant for you!",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      if (state is OnSuccessGetListFavorite)
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8 - 2,
                          child: ListView.builder(
                            itemCount: state.listRestaurant.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  Routers.detail,
                                  arguments: [
                                    state.listRestaurant[index].id,
                                    "favorite"
                                  ],
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
                                        "$baseUrlImage/${state.listRestaurant[index].pictureId}",
                                        width: 100,
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.listRestaurant[index].name ??
                                                "",
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
                                              Text(state.listRestaurant[index]
                                                      .city ??
                                                  ""),
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
