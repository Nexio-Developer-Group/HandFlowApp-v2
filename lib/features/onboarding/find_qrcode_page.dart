import 'package:flutter/material.dart';

class FindQRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {
                print('Skip');
              },
              child: Text("Skip"),
            ),
          ),
          Expanded(
            // ✅ This makes the middle area take up remaining space
            child: Center(
              child: Text(
                "Scan the QR code to continue",
                // style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  print("Back");
                },
                child: Icon(Icons.arrow_back_ios_new_rounded),
              ),
              ElevatedButton(
                onPressed: () {
                  print("Next");
                },
                child: Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
