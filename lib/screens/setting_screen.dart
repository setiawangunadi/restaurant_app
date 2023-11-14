import 'package:flutter/material.dart';
import 'package:restaurant_app/config/data/local/shared_prefs_storage.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isEnabled = false;

  @override
  void initState() {
    initialData();
    super.initState();
  }

  initialData() async {
    int value = await SharedPrefsStorage.getNotification() ?? 0;
    if (value == 0) {
      setState(() {
        isEnabled = false;
      });
    } else {
      setState(() {
        isEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text("Enabled Notification"),
                ),
                Switch(
                  value: isEnabled,
                  onChanged: (value) async {
                    if (value == true) {
                      await SharedPrefsStorage.setNotification(
                          notification: 1);
                    } else {
                      await SharedPrefsStorage.setNotification(
                          notification: 0);
                    }
                    setState(() {
                      isEnabled = !isEnabled;
                    });
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
