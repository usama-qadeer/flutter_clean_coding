import 'package:flutter/material.dart';

class NoDataFoundView extends StatelessWidget {
  final String message;
  const NoDataFoundView({super.key, this.message = "No data available"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );
  }
}
