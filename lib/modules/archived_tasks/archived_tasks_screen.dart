import 'package:flutter/cupertino.dart';

class ArchivedTasksScreen extends StatelessWidget{
  const ArchivedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'archived Tasks',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}