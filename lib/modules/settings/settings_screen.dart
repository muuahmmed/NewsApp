import 'package:flutter/cupertino.dart';

class SettingsScreen extends StatelessWidget
{

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Container(

        child: const Text(
          'Settings Screen',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }

}