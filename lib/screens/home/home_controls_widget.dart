import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/home/home_bloc.dart';

class HomeControls extends StatelessWidget {
  const HomeControls({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          final homePlayerState = context.watch<HomeBloc>().state;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                onPressed: () {
                  // Implementiere Logik für den linken Button
                },
                tooltip: "Aktuellen Song bewerten",
                child: const Icon(Icons.lyrics),
              ),
              const SizedBox(width: 30),
              FloatingActionButton(
                onPressed: () {
                  var bloc = context.read<HomeBloc>();
                  if (homePlayerState is! HomePlayerPlayingState) {
                    bloc.add(HomePlayerStarted());
                  } else {
                    bloc.add(HomePlayerStopped());
                  }
                },
                child: homePlayerState is HomePlayerInitializationState ?
                  CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  )
                 : Icon(homePlayerState is HomePlayerPlayingState ? Icons.pause : Icons.play_arrow),
                ),
              const SizedBox(width: 30),
              FloatingActionButton(
                onPressed: () {
                  // Implementiere Logik für den rechten Button
                },
                tooltip: "Moderator bewerten",
                child: const Icon(Icons.grade),
              ),
            ],
          );
        }
    );
  }
}