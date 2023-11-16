import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/search/search_bloc.dart';
import 'package:restaurant_app/config/data/local/constants.dart';
import 'package:restaurant_app/routers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc searchBloc;
  final TextEditingController ctrlSearch = TextEditingController();

  @override
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Search",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: ctrlSearch,
                        onFieldSubmitted: (value) => searchBloc.add(
                          DoSearchRestaurant(query: value),
                        ),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () => searchBloc.add(
                              DoSearchRestaurant(query: ctrlSearch.text),
                            ),
                            child: const Icon(Icons.search),
                          ),
                          hintText: "Cari Disini...",
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  if (state is OnLoadingSearch)
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 100,
                        ),
                        SizedBox(height: 16),
                        Text("Finding Restaurant For You")
                      ],
                    ),
                  if (state is OnSuccessSearch)
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        itemCount: state.searchResponse.founded,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              Routers.detail,
                              arguments: [
                                state.searchResponse.restaurants?[index].id,
                                "search",
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
                                    "$baseUrlImage/${state.searchResponse.restaurants?[index].pictureId}",
                                    width: 100,
                                  ),
                                  const SizedBox(width: 16),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.searchResponse.restaurants?[index]
                                                .name ??
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
                                          Text(state.searchResponse
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
                                          Text(state.searchResponse
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
                  if (state is OnFailedSearch)
                    Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.lightBlue,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
