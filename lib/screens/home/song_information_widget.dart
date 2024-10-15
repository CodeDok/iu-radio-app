import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radio_app/bloc/home/home_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SongInformation extends StatelessWidget {
  const SongInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomePlayerState>(
      builder: (context, state) {
        final title = state is HomePlayerPlayingState ? state.songInformation.title : '-';
        final interpret = state is HomePlayerPlayingState ? state.songInformation.interpret : '-';

        return Container(
          constraints: BoxConstraints(
            minHeight: 70
          ),
          child: Column(
            children: [
              state is HomePlayerInitializationState
                  ? LoadingAnimationWidget.staggeredDotsWave(color: Colors.black, size: 20)
                  : Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Interpret: ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  state is HomePlayerInitializationState
                      ? LoadingAnimationWidget.staggeredDotsWave(color: Colors.black, size: 20)
                      : Text(
                          interpret,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
