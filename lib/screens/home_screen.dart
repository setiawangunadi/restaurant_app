import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/home/home_bloc.dart';
import 'package:restaurant_app/config/data/handler/notification_helper.dart';
import 'package:restaurant_app/config/data/local/constants.dart';
import 'package:restaurant_app/routers.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc homeBloc;
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetListRestaurant());
    super.initState();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    didReceiveLocalNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is OnSuccessGetRestaurant) {
          homeBloc.add(DoSetNotification(data: state.listRestaurantModel));
        }
        if (state is OnSuccessSetNotification) {
          _notificationHelper.configureSelectNotificationSubject(
              context: context, id: state.id);
          _notificationHelper.configureDidReceiveLocalNotificationSubject(
              context: context, id: state.id);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routers.favorite),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routers.search),
                  child: const Icon(
                    Icons.saved_search_rounded,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routers.setting),
                  child: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header(),
                if (state is OnFailedHome)
                  Text(
                    state.message,
                    style: const TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                if (state is OnLoadingHome)
                  Shimmer.fromColors(
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
                  ),
                if (state is OnSuccessGetRestaurant)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.8 - 10,
                    child: ListView.builder(
                      itemCount: state.listRestaurantModel.count,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.pushNamed(
                            context,
                            Routers.detail,
                            arguments: [
                              state.listRestaurantModel.restaurants?[index].id,
                              "home",
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
                                  "$baseUrlImage/${state.listRestaurantModel.restaurants?[index].pictureId}",
                                  width: 100,
                                ),
                                const SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.listRestaurantModel
                                              .restaurants?[index].name ??
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
                                        Text(state.listRestaurantModel
                                                .restaurants?[index].city ??
                                            ""),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(state.listRestaurantModel
                                                .restaurants?[index].rating
                                                .toString() ??
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

  Widget header() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Restaurant",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          "Recommendation restaurant for you!",
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
