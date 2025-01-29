import 'package:ducker/ducker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final future = duckerInfo(iosAppId: '422689480');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ducker',
      home: FutureBuilder<DuckerInfo>(
        future: future,
        builder: (context, snapshot) {
          final x = snapshot.data;
          if (x == null) return CircularProgressIndicator.adaptive();

          return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                DefaultTextStyle(
                  style: TextStyle(fontSize: 48),
                  child: Stack(
                    children: [
                      Text("🦆"),
                      if (!x.duck) Text("❌"),
                    ],
                  ),
                ),
                Text([
                  "packageVersion: ${x.packageVersion}",
                  "deployedIosVersion: ${x.deployedIosVersion}",
                  "appIsLive: ${x.appIsLive}",
                  "duck: ${x.duck}",
                ].join('\n')),
              ],
            ),
          );
        },
      ),
    );
  }
}
