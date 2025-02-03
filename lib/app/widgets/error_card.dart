import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onReload;

  const ErrorCard({
    required this.title,
    required this.description,
    required this.onReload,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: onReload,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
