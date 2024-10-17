import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/home/home_bloc.dart';
import 'package:radio_app/screens/rating/moderator_rating_screen.dart';
import 'package:radio_app/screens/rating/song_rating_screen.dart';

class HomeControls extends StatelessWidget {
  const HomeControls({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomePlayerState>(builder: (context, state) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is HomePlayerPlayingState) ...[
                FloatingActionButton(
                  heroTag: "Song",
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SongRatingScreen(
                            songTitle: state.songInformation.title, interpret: state.songInformation.interpret),
                      ),
                    );
                  },
                  tooltip: "Rate current song",
                  child: const Icon(Icons.stars),
                ),
              ],
              const SizedBox(width: 30),
              FloatingActionButton(
                onPressed: () {
                  var bloc = context.read<HomeBloc>();
                  if (state is! HomePlayerPlayingState) {
                    bloc.add(HomePlayerStarted());
                  } else {
                    bloc.add(HomePlayerStopped());
                  }
                },
                child: state is HomePlayerInitializationState
                    ? CircularProgressIndicator(
                        strokeWidth: 3,
                      )
                    : Icon(state is HomePlayerPlayingState ? Icons.pause : Icons.play_arrow),
              ),
              const SizedBox(width: 30),
              if (state is HomePlayerPlayingState) ...[
                FloatingActionButton(
                  heroTag: "Wish",
                  onPressed: () {},
                  tooltip: "Wish song",
                  child: const Icon(Icons.lyrics),
                ),
              ]
            ],
          ),
          if (state is HomePlayerPlayingState) ...[
            const SizedBox(height: 30),
            FloatingActionButton.extended(
              heroTag: "Moderator",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ModeratorRatingScreen(),
                  ),
                );
              },
              tooltip: "Rate current moderator",
              label: const Text("Rate moderator"),
              icon: const Icon(Icons.stars),
            ),
          ]
        ],
      );
    });
  }
}
