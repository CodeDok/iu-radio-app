// home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:radio_app/bloc/home/home_bloc.dart';
import 'package:radio_app/repository/radioplayer/radio_player_repository.dart';
import 'package:radio_app/screens/app-scaffold.dart';
import 'package:radio_app/screens/home/home_controls_widget.dart';
import 'package:radio_app/screens/home/song_information_widget.dart';
import 'package:radio_app/screens/widgets/rounded_square_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String url = dotenv.get("RADIO_STATION_STREAM_URL");
    return AppScaffold(
      headerTitle: "Radio-Station",
      body: RepositoryProvider(
        create: (context) => RadioPlayerRepository.fromUrl(url),
        child: BlocProvider(
          lazy: false,
          create: (context) => HomeBloc(RepositoryProvider.of<RadioPlayerRepository>(context)),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 100),
                RoundedSquareContainer(imageWidget: Image.asset(
                  'assets/images/iu-radio-app-logo.png',
                  fit: BoxFit.cover,
                )),
                const SizedBox(height: 30),
                BlocConsumer<HomeBloc, HomePlayerState>(
                  listener: (context, state) {
                    if (state is HomePlayerFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: ${state.errorMessage}'),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SongInformation(),
                        const SizedBox(height: 30),
                        HomeControls(),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


