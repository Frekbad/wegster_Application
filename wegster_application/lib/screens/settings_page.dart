import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isNotificationEnabled = false;
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isNotificationEnabled = prefs.getBool('isNotificationEnabled') ?? false;
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'English';
    });
  }

  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isNotificationEnabled', isNotificationEnabled);
    await prefs.setString('selectedLanguage', selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: SwitchListTile(
            title: Text('Enable Notifications'),
            value: isNotificationEnabled,
            onChanged: (value) {
              setState(() {
                isNotificationEnabled = value;
              });
              saveSettings();
            },
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            title: Text('Language'),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              onChanged: (value) {
                setState(() {
                  selectedLanguage = value!;
                });
                saveSettings();
              },
              items: [
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'Spanish',
                  child: Text('Spanish'),
                ),
                DropdownMenuItem(
                  value: 'French',
                  child: Text('French'),
                ),
              ],
            ),
          ),
        ),
        const Card(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListTile(
            title: Text('Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ),
      ]),
    );
  }
}
