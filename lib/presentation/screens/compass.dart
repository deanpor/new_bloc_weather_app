// compass_page.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubits/compass_cubit.dart';

class CompassPage extends StatelessWidget {
  const CompassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Compass"),
      ),
      body: BlocBuilder<CompassCubit, CompassState>(
        builder: (context, state) {
          // Calculate the rotation angle based on the heading
          double rotationAngle = -(state.heading ?? 0) * (pi / 180);

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${state.heading.ceil()}°",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset("assets/cadrant.png"),
                    Transform.rotate(
                      angle: rotationAngle,
                      child: Image.asset(
                        "assets/compass.png",
                        scale: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
