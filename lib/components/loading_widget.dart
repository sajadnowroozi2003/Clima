import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loadingWidget extends StatelessWidget {
  const loadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightColor,
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SpinKitCircle(
            color: Colors.white,
            size: 100,
          ),
          SizedBox(height: 10),
          Text(
            'Fatching data ...',
            style: TextStyle(fontSize: 20, color: kMidlightColor),
          )
        ],
      )),
    );
  }
}
