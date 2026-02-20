import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyPage()));

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mera Pehla Flutter App')),
      body: Center(
        child: Text(
          'GitHub ne ye APK banayi hai!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
