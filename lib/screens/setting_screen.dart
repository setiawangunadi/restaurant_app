import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/blocs/setting/setting_bloc.dart';
import 'package:restaurant_app/config/data/local/shared_prefs_storage.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late SettingBloc _settingBloc;
  bool isEnabled = false;

  @override
  void initState() {
    _settingBloc = BlocProvider.of<SettingBloc>(context);
    initialData();
    super.initState();
  }

  initialData() async {
    int value = await SharedPrefsStorage.getNotification() ?? 0;
    _settingBloc.add(DoChangeNotification(isNotification: value));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingBloc, SettingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Setting"),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              if (state is OnLoadingSetting)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              if (state is OnSuccessChangeNotification)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text("Enabled Notification"),
                          ),
                          Switch(
                            value: state.isEnabled,
                            onChanged: (value) async {
                              if (value == true) {
                                _settingBloc.add(
                                    DoChangeNotification(isNotification: 1));
                              } else {
                                _settingBloc.add(
                                    DoChangeNotification(isNotification: 0));
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
