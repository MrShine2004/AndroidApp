import 'package:flutter/material.dart';
import 'package:cpsrpoproject/app/app.dart';

class CarsDiscriptionScreen extends StatefulWidget {
  const CarsDiscriptionScreen({super.key});
  @override
  State<CarsDiscriptionScreen> createState() => _CarsDiscriptionScreenState();
}

class _CarsDiscriptionScreenState extends State<CarsDiscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cars',
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Car',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              20.ph,
              Image.asset(
                'assets/images/car.jpg',
                fit: BoxFit.cover,
              ),
              20.ph,
              Text(
                'Discription',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              10.ph,
              Text(
                'TextDiscription',
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
