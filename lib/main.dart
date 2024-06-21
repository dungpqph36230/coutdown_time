import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(CountdownApp());
}

class CountdownApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Countdown Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountdownScreen(),
    );
  }
}

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  int totalSeconds = 0;
  Timer? timer;

  void startCountdown() {
    totalSeconds = hours * 3600 + minutes * 60 + seconds;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) { 
          totalSeconds--;
          hours = totalSeconds ~/ 3600;
          minutes = (totalSeconds % 3600) ~/ 60;
          seconds = totalSeconds % 60;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown Timer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nhập thời gian đếm ngược:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Giờ'),
                    onChanged: (value) {
                      setState(() {
                        hours = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Phút'),
                    onChanged: (value) {
                      setState(() {
                        minutes = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Giây'),
                    onChanged: (value) {
                      setState(() {
                        seconds = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                startCountdown();
              },
              child: Text('Bắt đầu'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Thời gian còn lại:',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}