import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final TextEditingController _controllerServerUrl = TextEditingController();
  final TextEditingController _controllerAPIKey = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _controllerServerUrl.text = prefs.getString("serverUrl") ?? '';
      _controllerAPIKey.text = prefs.getString("apiKey") ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Fog Forcast',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('An AQi and weather forcast app'),
            const SizedBox(height: 20),
            Card(
                child: Column(
              children: [
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text(
                        'Setting',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                ListTile(
                    title: const Text('Server Address'),
                    subtitle: const Text('For example：http://server.demo'),
                    onTap: () => showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              title: const Text("Enter server address"),
                              content: TextField(
                                controller: _controllerServerUrl,
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                  hintText: 'No trailing slash',
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    setState(() {
                                      prefs.setString("serverUrl",
                                          _controllerServerUrl.text);
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const Text('Save'),
                                ),
                              ],
                            )))),
              ],
            )),
            const SizedBox(height: 20),
            Card(
                child: Column(
              children: [
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      child: Text(
                        'Others',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const ListTile(
                  title: Text('Version'),
                  subtitle: Text('1.0.1'),
                ),
                ListTile(
                  title: const Text('About'),
                  subtitle: const Text('About Fog Forcase'),
                  onTap: () => showMessageDialog(context, "About",
                      "Credits: Huang Shuo, Huang Rongkai, Wen Kangda\n\nPowered by Flutter"),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

void showMessageDialog(BuildContext context, String title, String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      );
    },
  );
}
