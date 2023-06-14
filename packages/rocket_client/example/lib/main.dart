import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:rocket_client/rocket_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RocketClientExample(),
    );
  }
}

class RocketClientExample extends StatefulWidget {
  const RocketClientExample({super.key});

  @override
  RocketClientExampleState createState() => RocketClientExampleState();
}

class RocketClientExampleState extends State<RocketClientExample> {
  final client = RocketClient(url: 'https://jsonplaceholder.typicode.com');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rocket Example'),
      ),
      body: Center(
        child: isLoading
            // ignore: prefer_const_constructors
            ? CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  isLoading = true;
                  setState(() {});
                  // Make a GET request to the /posts endpoint
                  final response = await client.request('posts');
                  isLoading = false;
                  setState(() {});
                  // Display the response in a dialog
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Response'),
                        content: Text(json.encode(response)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Make Request'),
              ),
      ),
    );
  }
}
